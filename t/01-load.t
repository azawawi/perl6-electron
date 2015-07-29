use v6;

use Test;
use lib 'lib';

plan 2;

use Atom::Electron;
ok 1, "'use Atom::Electron' worked!";
ok Atom::Electron.new, "Atom::Electron.new worked";
