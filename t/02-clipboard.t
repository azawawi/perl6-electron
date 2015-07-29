use v6;

use Test;

use lib 'lib';

# Methods to test
my @methods = 'write_text', 'read_text', 'clear';

plan @methods.elems + 3;

{
  # Skip tests if the electron executable is not found
  use File::Which;
  unless which('electron') {
    skip-rest("electron is not installed. skipping tests...");
    exit;
  }
}

use Atom::Electron::Clipboard;
ok 1, "'use Atom::Electron::Clipboard' worked!";

for @methods -> $method {
  ok Atom::Electron::Clipboard.can($method), "Clipboard.$method is found";
}

my $app = Atom::Electron::App.instance;
LEAVE {
  diag 'Destroy electron app';
  $app.destroy;
}

# Write to clipboard
my $t1 = 'Hello world';
Atom::Electron::Clipboard.write_text($t1);

# Read and match if it is the same
my $t2 = Atom::Electron::Clipboard.read_text;
ok $t1 eq $t2, "write_text/read_text matched";

# Clear clipboard and check if its empty
Atom::Electron::Clipboard.clear;
my $empty = Atom::Electron::Clipboard.read_text;
ok $empty eq '', "clear clipboard worked";
