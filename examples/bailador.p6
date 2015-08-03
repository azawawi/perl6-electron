#!/usr/bin/env perl6

use v6;

use lib 'lib';

# Hello world from Bailador as a separate async process
my $code = q!use Bailador; get '/' => sub { "Hello world from Bailador inside an Atom::Electron app" }; baile;!;
my $p = Proc::Async.new( "perl6", "-e", $code );
$p.start;

# Now to our application :)
use Atom::Electron;

my $app = Atom::Electron::App.instance;
LEAVE {
  $app.destroy;
  $p.kill;
}

my $window = Atom::Electron::BrowserWindow.new(:x(100), :y(100), :width(1024), :height(768));

$window.load-url("http://127.0.0.1:3000");

$window.on-minimize(sub {
  "Window minimized!".say;
});

$window.on-maximize(sub {
  "Window maximized!".say;
});

$app.event-loop;

