var app = require('app');  // Module to control application life.
var BrowserWindow = require('browser-window');  // Module to create native browser window.
var ipc = require('ipc');
var os = require("os");

console.log("main.js here");

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
  console.log('Application open for business :)');

  // Create a JSON::RPC server object
  var rpc = require('./node_modules/node-json-rpc');
  var server = new rpc.Server({
    port: 8080,
    host: '127.0.0.1',
    path: '/',
    strict: true
  });

  var handleId = 0;
  var handleStore = {};

  server.addMethod("ping", function(param, callback) {
      console.log("test called");
      
      var result = "Pong";
      console.log(result);
      callback(0, result);
  });

  server.addMethod('BrowserWindow-new', function(param, callback) {
    console.log("BrowserWindow-new called");
    
    param = param || {};
    var width = param.width || 1024;
    var height = param.height || 768;
    var dev_tools_enabled = param.dev_tools_enabled || false;

    // Create the browser window.
    var win = new BrowserWindow({
      "width": width,
      "height": height
    });

    var currentHandleId = ++handleId;
    handleStore[handleId] = win;

    // Open the devtools.
    if(dev_tools_enabled) {
      win.openDevTools();
    }

    var result = currentHandleId;

    console.log(result);
    callback(0, result);
  });

  server.addMethod('BrowserWindow-on', function(param, callback) {
    var win = handleStore[param.handle_id];
    if(win) {
      win.on(param.event_name, function() {
        callback(0, result);
      });
    } else {
      // Invalid handle id
    }
  });

  server.addMethod('BrowserWindow-load_url', function(param, callback) {
    console.log("BrowserWindow-load_url called");
    console.log(param);
    param = param || {};
    var width = param.width || 1024;
    var height = param.height || 768;
    var handleId = param.handle_id;
    var url = param.url || ('file://' + __dirName + '/index.html');
    console.log(handleId);
    
    if(handleId) {
      var win = handleStore[handleId];
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
  
  // Start the server
  server.start(function (error) {
    // Did server start succeed ?
    if (error) {
      throw error;
    } else {
      console.log('Server running ...');
    }
  });

/*
  var net = require('net');
  var server = net.createServer(function(socket) {
    console.log('client connected');
    socket.on('end', function() {
      console.log('client disconnected');
    });
    socket.write('{"result": 1}\n');
    //socket.pipe(socket);
  });
  server.listen(3333, function() {
    console.log('server bound');
  });
*/
});
