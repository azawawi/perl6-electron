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
  console.log('Application open for business :)');

  // Create a JSON::RPC client object
  var rpc = require('./node_modules/node-json-rpc');
  var client = new rpc.Client({
    port: 8080,
    host: '127.0.0.1',
    path: '/',
    strict: true
  });
  var server = new rpc.Server({
    port: 8081,
    host: '127.0.0.1',
    path: '/',
    strict: true
  });

  client.call(
    {"jsonrpc": "2.0", "method": "init", "params": [], "id": id++},
    function (err, res) {
      // Did it all work ?
      if (err) {
        console.log("error while connecting to Perl 6 JSON::RPC bridge")
      }
      else {
        console.log("JSON::RPC bridge started with main Perl 6 process");

        var result = res.result || {};
        var width = result.width || 1024;
        var height = result.height || 768;

        // Create the browser window.
        mainWindow = new BrowserWindow({
          "width": width,
          "height": height
        });

        // and load the index.html of the app.
        mainWindow.loadUrl('file://' + __dirname + '/index.html');

        // Open the devtools.
        if(result.openDevTools) {
          mainWindow.openDevTools();
        }

        // Emitted when the window is closed.
        mainWindow.on('closed', function() {
          // Dereference the window object, usually you would store windows
          // in an array if your app supports multi windows, this is the time
          // when you should delete the corresponding element.
          mainWindow = null;

          // Stop Perl process
          client.call(
            {
              "jsonrpc": "2.0", "method": "stop", "params": {}, "id": id++
            },
            function (err, res) {
              // Did it all work ?
              if (err) {
                console.log("Error: " + err);
              }
              else {
                console.log("Result is " + res.result);
              }
            }
          );

        });

      }
    }
  );

  var id = 0;

  ipc.on('sum', function(event, a, b) {
    client.call(
      {"jsonrpc": "2.0", "method": "sum", "params": {"a": a, "b": b}, "id": id++},
      function (err, res) {
        // Did it all work ?
        if (err) {
          event.sender.send('sum-reply', "Error: " + err);
        }
        else {
          event.sender.send('sum-reply', res.result);
        }
      }
    );
  });

});
