use v6;

use Test;
use lib 'lib';

plan 2;

use Electron;
ok 1, "'use Electron' worked!";
ok Electron.new, "Electron.new worked";
