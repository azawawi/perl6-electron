#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Atom::Electron;

my $app = Atom::Electron::App.instance;
LEAVE {
  $app.destroy;
}

say Atom::Electron::Screen.get_cursor_screen_point.perl;

say Atom::Electron::Screen.get_primary_display.perl;

say Atom::Electron::Screen.get-all-displays.perl;

say Atom::Electron::Screen.get-display-nearest-point({x => 0, y => 0}).perl;

say Atom::Electron::Screen.get-display-matching({x => 0, y => 0, width => 800, height => 600}).perl;

prompt("Press any key to exit");
