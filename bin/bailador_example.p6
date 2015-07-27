#!/usr/bin/env perl6

use v6;

use lib 'lib';

# Hello world from Bailador
use Bailador;
get '/' => sub {
    "hello world from Bailador inside Electron. This is possible using Atom::Electron :)"
}

# Now to our application :)
use Atom::Electron;

my $app = Atom::Electron::App.instance;
my $window = Atom::Electron::BrowserWindow.new(:x(100), :y(100), :width(1024), :height(768));

# start Bailador in the background
start {
  baile;
};

$window.load_url("http://127.0.0.1:3000");

$window.on('minimize', sub {
  "Window minimized!".say;
});

$window.on('maximize', sub {
  "Window maximized!".say;
});

$app.event_loop;
$app.destroy;

