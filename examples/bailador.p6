#!/usr/bin/env perl6

use v6;

use lib 'lib';

# Hello world from Bailador as a separate async process
my $code = q!use Bailador; get '/' => sub { "Hello world from Bailador inside an Electron app" }; baile;!;
my $p = Proc::Async.new( "perl6", "-e", $code );
$p.start;

# Now to our application :)
use Electron;

my $app = Electron::App.instance;
LEAVE {
  $app.destroy if $app.defined;
  $p.kill if $p.defined;
}

my $window = Electron::BrowserWindow.new(:x(100), :y(100), :width(1024), :height(768));

$window.load-url("http://127.0.0.1:3000");

$window.on-minimize(sub {
  "Window minimized!".say;
});

$window.on-maximize(sub {
  "Window maximized!".say;
});

$app.run;

