#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Electron;

my $app = Electron::App.instance;
LEAVE {
  $app.destroy if $app.defined;
}

my $file = 'META.info';
Electron::Shell.open-item($file);

Electron::Shell.show-item-in-folder($file);

Electron::Shell.open-external("http://doc.perl6.org");

my $file-to-delete = "delete-me.txt";
$file-to-delete.IO.spurt("Hello world");
Electron::Shell.move-item-to-trash($file-to-delete);

Electron::Shell.beep;

prompt("Press any key to exit");
