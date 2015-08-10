#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Electron;


my $app = Electron::App.instance;
LEAVE {
  $app.destroy if $app.defined;
}

my $win = Electron::BrowserWindow.new(
  :x(100), :y(100), :width(1024), :height(768), :show(False)
);

$win.load-url("http://www.google.com");

$win.on-minimize( sub {
  "Window minimized!".say;
});

$win.on-maximize( sub {
  "Window maximized!".say;
});

$win.on-devtools-closed( sub {
  "Dev tools closed!".say;
});

$win.show;

$app.run;

prompt("Press any key to exit");
