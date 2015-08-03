#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Atom::Electron;

my $app = Atom::Electron::App.instance;
LEAVE {
  $app.destroy;
}

my $file = 'META.info';
Atom::Electron::Shell.open-item($file);

Atom::Electron::Shell.show-item-in-folder($file);

Atom::Electron::Shell.open-external("http://doc.perl6.org");

my $file-to-delete = "delete-me.txt";
$file-to-delete.IO.spurt("Hello world");
Atom::Electron::Shell.move-item-to-trash($file-to-delete);

Atom::Electron::Shell.beep;

prompt("Press any key to exit");
