use v6;

use Test;

use lib 'lib';

# Methods to test
my @methods = 'write-text', 'read-text', 'clear';

plan @methods.elems + 3;

use Atom::Electron::Clipboard;
ok 1, "'use Atom::Electron::Clipboard' worked!";

for @methods -> $method {
  ok Atom::Electron::Clipboard.can($method), "Clipboard.$method is found";
}

{
  # Skip tests if the electron executable is not found
  use File::Which;
  unless which('electron') {
    skip-rest("electron is not installed. skipping tests...");
    exit;
  }
}

my $app = Atom::Electron::App.instance;
LEAVE {
  diag 'Destroy electron app';
  $app.destroy;
}

# Write to clipboard
my $t1 = 'Hello world';
Atom::Electron::Clipboard.write-text($t1);

# Read and match if it is the same
my $t2 = Atom::Electron::Clipboard.read-text;
ok $t1 eq $t2, "write-text/read-text matched";

# Clear clipboard and check if its empty
Atom::Electron::Clipboard.clear;
my $empty = Atom::Electron::Clipboard.read-text;
ok $empty eq '', "clear clipboard worked";
