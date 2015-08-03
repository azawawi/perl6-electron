// Module to control application life.
var app           = require('app');

// Module to create native browser window.
var BrowserWindow = require('browser-window');

// Quit when all windows are closed.
app.on('window-all-closed', function() {
  if (process.platform != 'darwin') {
    app.quit();
  }
});

// This method will be called when Electron has done everything
// initialization and ready for creating browser windows.
app.on('ready', function() {

  // Module for desktop integration
  var Shell         = require('shell');

  // Module for clipboard copy/paste integration
  var Clipboard     = require('clipboard');

  // Module for native system dialogs
  var Dialog = require('dialog');

  // Module for screens
  var Screen = require('screen');

  // Create a JSON::RPC server object
  var rpc = require('./node_modules/node-json-rpc');
  var server = new rpc.Server({
    port: 3333,
    host: '127.0.0.1',
    path: '/',
    strict: true
  });

  var handle = 0;
  var handleStore = {};
  var eventStore = [];

  server.addMethod('BrowserWindow-new', function(param, callback) {
    param = param || {};
    var x = param.x || 0;
    var y = param.y || 0;
    var width = param.width || 1024;
    var height = param.height || 768;
    var dev_tools_enabled = param.dev_tools_enabled || false;
    var show = param.show || false;
    var frame = param.frame || false;
    var kiosk = param.kiosk || false;

    // Create the browser window.
    var win = new BrowserWindow({
      "x"       : x,
      "y"       : y,
      "width"   : width,
      "height"  : height,
      "show"    : show,
      "frame"   : frame,
      "kiosk"   : kiosk,
    });

    var currentHandle = ++handle;
    handleStore[handle] = win;

    // Open the devtools.
    if(dev_tools_enabled) {
      win.openDevTools();
    }

    callback(0, currentHandle);
  });

  server.addMethod('BrowserWindow-on', function(param, callback) {
    var win = handleStore[param.handle];
    if(win && param.name) {
      win.on(param.name, function() {
        eventStore.push({
          id          : param.id,
          name        : param.name
        });
      });
    } else {
      // Invalid handle id
    }
    callback(0, {});
  });

  server.addMethod('BrowserWindow-load-url', function(param, callback) {
    param = param || {};
    var handle = param.handle;
    var url = param.url || ('file://' + __dirName + '/index.html');

    if(handle) {
      var win = handleStore[handle];
      if(win) {
        win.loadUrl(url);
      } else {
        // Invalid handle id
      }
    } else {
        // Invalid handle id
    }

    callback(0, {});
  });

  server.addMethod('BrowserWindow-show', function(param, callback) {
    param = param || {};
    var handle = param.handle;
    if(handle) {
      var win = handleStore[handle];
      if(win) {
        win.show();
      } else {
        // Invalid handle id
      }
    } else {
        // Invalid handle id
    }

    callback(0, {});
  });

  server.addMethod("get-pending-events", function(param, callback) {
    param = param || {};
    var result = {"events" : eventStore};
    eventStore = [];
    callback(0, result);
  });

  server.addMethod("App-quit", function(param, callback) {
    // We're done...
    setTimeout(function() {
      app.quit();
    }, 500)
    callback(0, {});
  });

  server.addMethod("Shell-show-item-in-folder", function(param, callback) {
    param = param || {};
    Shell.showItemInFolder(param.full_path);
    callback(0, {});
  });

  server.addMethod("Shell-open-item", function(param, callback) {
    param = param || {};
    Shell.openItem(param.full_path);
    callback(0, {});
  });

  server.addMethod("Shell-open-external", function(param, callback) {
    param = param || {};
    Shell.openExternal(param.url);
    callback(0, {});
  });

  server.addMethod("Shell-move-item-to-trash", function(param, callback) {
    param = param || {};
    Shell.moveItemToTrash(param.full_path);
    callback(0, {});
  });

  server.addMethod("Shell-beep", function(param, callback) {
    Shell.beep();
    callback(0, {});
  });

  server.addMethod("Clipboard-read-text", function(param, callback) {
    param = param || {};
    var result =  {text: Clipboard.readText(param.type)};
    callback(0, result);
  });

  server.addMethod("Clipboard-write-text", function(param, callback) {
    param = param || {};
    var text = param.text || '';
    Clipboard.writeText(text, param.type);
    callback(0, {});
  });

  server.addMethod("Clipboard-clear", function(param, callback) {
    Clipboard.clear();
    callback(0, {});
  });

  server.addMethod("Dialog-show-open-dialog", function(param, callback) {
    param = param || {};
    var handle  = param.handle   || -1;
    var win     = handleStore[handle];
    var options = param.options || {};
    var result = { "selected": Dialog.showOpenDialog(win, options) };
    callback(0, result);
  });

  server.addMethod("Dialog-show-save-dialog", function(param, callback) {
    param = param || {};
    var handle  = param.handle   || -1;
    var win     = handleStore[handle];
    var options = param.options || {};
    var result = { "selected": Dialog.showSaveDialog(win, options) };
    callback(0, result);
  });

  server.addMethod("Dialog-show-message-box", function(param, callback) {
    param = param || {};
    var handle  = param.handle   || -1;
    var win     = handleStore[handle];
    var options = param.options || {};
    var result = { "selected": Dialog.showMessageBox(win, options) };
    callback(0, result);
  });

  server.addMethod("Dialog-show-error-box", function(param, callback) {
    param = param || {};
    var text    = param.text || '';
    var content = param.content || '';
    Dialog.showErrorBox(text, content);
    callback(0, {});
  });

  server.addMethod("Screen-on", function(param, callback) {
    console.log("TODO unimplemented Screen-on");
    callback(0, {});
  });

  server.addMethod("Screen-get_cursor_screen_point", function(param, callback) {
    var result =  {"result": Screen.getCursorScreenPoint()};
    callback(0, result);
  });

  server.addMethod("Screen-get_primary_display", function(param, callback) {
    var result =  {"result": Screen.getPrimaryDisplay()};
    callback(0, result);
  });

  server.addMethod("Screen-get-all-displays", function(param, callback) {
    var result =  {"result": Screen.getAllDisplays()};
    callback(0, result);
  });

  server.addMethod("Screen-get-display-nearest-point", function(param, callback) {
    param      = param || {};
    var point  = param.point   || {};
    var result =  {"result": Screen.getDisplayNearestPoint(point)};
    callback(0, result);
  });

  server.addMethod("Screen-get-display-matching", function(param, callback) {
    param      = param || {};
    var rect  = param.rect   || {};
    var result =  {"result": Screen.getDisplayMatching(rect)};
    callback(0, result);
  });

  server.addMethod("Process-versions", function(param, callback) {
    var result =  {"result": process.versions};
    callback(0, result);
  });

  // Start the server
  server.start(function (error) {
    if (error) {
      // server failed to start
      throw error;
    }
  });

});
