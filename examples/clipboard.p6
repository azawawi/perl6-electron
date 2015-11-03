#!/usr/bin/env perl6

use v6;



use Electron;

my $app = Electron::App.instance;
LEAVE {
  $app.destroy if $app.defined;
}

my $text = 'Hello world';
say "Writing to clipboard the following: $text";
Electron::Clipboard.write-text($text);

say "Read from clipboard the following: " ~ Electron::Clipboard.read-text;

say "Clearing clipboard";
Electron::Clipboard.clear;

say "Read from clipboard the following: " ~ Electron::Clipboard.read-text;

prompt("Press any key to exit");
