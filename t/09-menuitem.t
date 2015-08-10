use v6;

use Test;

use lib 'lib';

# Methods to test
plan 2;

use Electron::MenuItem;
ok 1, "'use Electron::MenuItem' worked!";
ok Electron::MenuItem.new, "'Electron::MenuItem.new' worked!";
