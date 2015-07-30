#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Atom::Electron;

my $app = Atom::Electron::App.instance;
LEAVE {
  $app.destroy;
}

my $file = 'META.info';
Atom::Electron::Shell.open_item($file);

Atom::Electron::Shell.show_item_in_folder($file);

Atom::Electron::Shell.open_external("http://doc.perl6.org");

my $file_to_delete = "safe-to-delete.txt";
$file_to_delete.IO.spurt("Hello world");
Atom::Electron::Shell.move_item_to_trash($file_to_delete);

Atom::Electron::Shell.beep;

prompt("Press any key to exit");
