#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Atom::Electron;

my $app = Atom::Electron::App.instance;
LEAVE {
  $app.destroy;
}

say Atom::Electron::Process.versions.perl;

say Atom::Electron::Process.electron-version;

say Atom::Electron::Process.chrome-version;

prompt("Press any key to exit");
