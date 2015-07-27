var app = require('app');  // Module to control application life.
var BrowserWindow = require('browser-window');  // Module to create native browser window.
var ipc = require('ipc');
var os = require("os");

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the javascript object is GCed.
var mainWindow = null;

// Quit when all windows are closed.
app.on('window-all-closed', function() {
  if (process.platform != 'darwin') {
    app.quit();
  }
});

// This method will be called when Electron has done everything
// initialization and ready for creating browser windows.
app.on('ready', function() {
  console.log('Application is ready. Creating JSON RPC bridge...');

  // Create a JSON::RPC server object
  var rpc = require('./node_modules/node-json-rpc');
  var server = new rpc.Server({
    port: 8080,
    host: '127.0.0.1',
    path: '/',
    strict: true
  });

  var handle = 0;
  var handleStore = {};

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

    var result = currentHandle;
    callback(0, result);
  });

  server.addMethod('BrowserWindow-on', function(param, callback) {
    var win = handleStore[param.handle];
    console.log("event name = " + param.event_name);
    if(win && param.event_name) {
      console.log("on(" + param.event_name + ")")
      win.on(param.event_name, function() {
        console.log("Got event " + param.event_name);
        //var result = {};
        callback(0, result);
      });
    } else {
      // Invalid handle id
    }
    var result = {};
    callback(0, result);
  });

  server.addMethod('BrowserWindow-load_url', function(param, callback) {
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

    var result = {};
    callback(0, result);
  });

  server.addMethod('BrowserWindow-show', function(param, callback) {
    param = param || {};
    var handle = param.handle;
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

    var result = {};
    callback(0, result);
  });

  server.addMethod("get_pending_events", function(param, callback) {
    param = param || {};

    console.log("get_pending_events called!");
    var result = {};
    callback(0, result);
  });

  // Start the server
  server.start(function (error) {
    // Did server start succeed ?
    if (error) {
      throw error;
    } else {
      console.log('Server running ...');
    }
  });

});
