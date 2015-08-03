#!/usr/bin/env perl6

use v6;

use lib 'lib';

use Atom::Electron;

my $app = Atom::Electron::App.instance;
LEAVE {
  $app.destroy;
}

my $text = 'Hello world';
say "Writing to clipboard the following: $text";
Atom::Electron::Clipboard.write-text($text);

say "Read from clipboard the following: " ~ Atom::Electron::Clipboard.read-text;

say "Clearing clipboard";
Atom::Electron::Clipboard.clear;

say "Read from clipboard the following: " ~ Atom::Electron::Clipboard.read-text;

prompt("Press any key to exit");
