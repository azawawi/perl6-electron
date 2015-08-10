use v6;

use Test;

use lib 'lib';

# Methods to test
my @methods = 'load-url', 'show', 'on', 'on-page-title-updated',
  'on-close', 'on-closed', 'on-unresponsive', 'on-responsive',
  'on-blur', 'on-focus', 'on-maximize', 'on-unmaximize', 'on-minimize',
  'on-restore', 'on-resize', 'on-move', 'on-moved', 'on-enter-full-screen',
  'on-leave-full-screen', 'on-enter-html-full-screen', 'on-leave-html-full-screen',
  'on-devtools-opened', 'on-devtools-closed', 'on-devtools-focused',
  'on-app-command';

plan @methods.elems + 1;

use Electron::BrowserWindow;
ok 1, "'use Electron::BrowserWindow' worked!";

for @methods -> $method {
  ok Electron::BrowserWindow.can($method), "BrowserWindow.$method is found";
}
