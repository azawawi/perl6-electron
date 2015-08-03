#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Atom::Electron;

my $app = Atom::Electron::App.instance;
LEAVE {
  $app.destroy;
}

say Atom::Electron::Dialog.show-open-dialog.perl;

say Atom::Electron::Dialog.show-save-dialog.perl;

say Atom::Electron::Dialog.show-message-box.perl;

Atom::Electron::Dialog.show-error-box("Text", "Content");

prompt("Press any key to exit");
