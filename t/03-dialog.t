use v6;

use Test;

use lib 'lib';

# Methods to test
my @methods = 'show_open_dialog', 'show_save_dialog', 'show_message_box', 'show_error_box';

plan @methods.elems + 1;

use Atom::Electron::Dialog;
ok 1, "'use Atom::Electron::Dialog' worked!";

for @methods -> $method {
  ok Atom::Electron::Dialog.can($method), "Dialog.$method is found";
}
