use v6;

use Test;
use lib 'lib';

# Methods to test
my @methods = 'show-open-dialog', 'show-save-dialog', 'show-message-box', 'show-error-box';

plan @methods.elems + 1;

use Electron::Dialog;
ok 1, "'use Electron::Dialog' worked!";

for @methods -> $method {
  ok Electron::Dialog.can($method), "Dialog.$method is found";
}
