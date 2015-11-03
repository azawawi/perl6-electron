use v6;

use Test;

# Methods to test
my @methods = 'write-text', 'read-text', 'clear';

plan @methods.elems + 3;

use Electron::Clipboard;
ok 1, "'use Electron::Clipboard' worked!";

for @methods -> $method {
  ok Electron::Clipboard.can($method), "Clipboard.$method is found";
}

{
  # Skip tests if the electron executable is not found
  use File::Which;
  unless which('electron') {
    skip-rest("electron is not installed. skipping tests...");
    exit;
  }
}

my $app = Electron::App.instance;
LEAVE {
  diag 'Destroy electron app';
  $app.destroy;
}

# Write to clipboard
my $t1 = 'Hello world';
Electron::Clipboard.write-text($t1);

# Read and match if it is the same
my $t2 = Electron::Clipboard.read-text;
ok $t1 eq $t2, "write-text/read-text matched";

# Clear clipboard and check if its empty
Electron::Clipboard.clear;
my $empty = Electron::Clipboard.read-text;
ok $empty eq '', "clear clipboard worked";
