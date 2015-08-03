#!/usr/bin/env perl6

use v6;

use lib 'lib';

# Hello world from HTTP::Server::Async
use HTTP::Server::Async;
my $server = HTTP::Server::Async.new(:port(3000));
$server.register(sub ($request, $response, $next) {
  $response.headers<Content-Type> = 'text/plain';
  $response.status = 200;
  $response.write("Hello ");
  $response.close("world from HTTP::Server::Async!"); #keeps a promise in the response and ends the server handler processing
});

# Listen async
$server.listen;

# Now to our application :)
use Atom::Electron;

my $app = Atom::Electron::App.instance;
LEAVE {
  $app.destroy;
}

my $window = Atom::Electron::BrowserWindow.new(:x(100), :y(100), :width(1024), :height(768));

$window.load-url("http://127.0.0.1:3000");

$window.on-minimize( sub {
  "Window minimized!".say;
});

$window.on-maximize( sub {
  "Window maximized!".say;
});

$app.event-loop;
