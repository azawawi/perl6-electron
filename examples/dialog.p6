#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Electron;

my $app = Electron::App.instance;
LEAVE {
  $app.destroy;
}

say Electron::Dialog.show-open-dialog.perl;

say Electron::Dialog.show-save-dialog.perl;

say Electron::Dialog.show-message-box.perl;

Electron::Dialog.show-error-box("Text", "Content");

prompt("Press any key to exit");
