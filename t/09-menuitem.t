use v6;

use Test;

use lib 'lib';

# Methods to test
plan 2;

use Atom::Electron::MenuItem;
ok 1, "'use Atom::Electron::MenuItem' worked!";
ok Atom::Electron::MenuItem.new, "'Atom::Electron::MenuItem.new' worked!";
