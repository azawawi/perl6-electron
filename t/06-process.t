use v6;

use Test;

use lib 'lib';

# Methods to test
my @methods = 'versions', 'electron-version', 'chrome-version';

plan @methods.elems + 8;

use Electron::Process;
ok 1, "'use Electron::Process' worked!";

for @methods -> $method {
  ok Electron::Process.can($method), "Process.$method is found";
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

my $versions = Electron::Process.versions;
ok $versions ~~ Hash, 'Return result is a hash';
ok $versions<electron>, 'electron key is found';
ok $versions<chrome>, 'chrome key is found';

my $v;

$v = Electron::Process.chrome-version;
diag "Chrome version: $v";
ok $v ~~ Str, 'Chrome version string is a string';
ok $v.elems > 0, 'Chrome version string is not empty';

$v = Electron::Process.electron-version;
diag "Electron version: $v";
ok $v ~~ Str, 'Electron version string is a string';
ok $v.elems > 0, 'Electron version string is not empty';
