#!/usr/bin/env perl6

use v6;



use Electron;

my $app = Electron::App.instance;
LEAVE {
  $app.destroy if $app.defined;
}

say Electron::Process.versions.perl;

say Electron::Process.electron-version;

say Electron::Process.chrome-version;

prompt("Press any key to exit");
