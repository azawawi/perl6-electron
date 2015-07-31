use v6;

use Test;

use lib 'lib';

# Methods to test
my @methods = 'show_item_in_folder', 'open_item', 'open_external',
  'move_item_to_trash', 'beep';

plan @methods.elems + 1;

use Atom::Electron::Shell;
ok 1, "'use Atom::Electron::Shell' worked!";

for @methods -> $method {
  ok Atom::Electron::Shell.can($method), "Shell.$method is found";
}
