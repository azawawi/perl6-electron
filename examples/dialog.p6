#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Atom::Electron;

my $app = Atom::Electron::App.instance;
LEAVE {
  $app.destroy;
}

say Atom::Electron::Dialog.show_open_dialog.perl;

say Atom::Electron::Dialog.show_save_dialog.perl;

say Atom::Electron::Dialog.show_message_box.perl;

Atom::Electron::Dialog.show_error_box("Text", "Content");

prompt("Press any key to exit");
