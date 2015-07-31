use v6;

use Test;

use lib 'lib';

# Methods to test
my @methods = 'on', 'on-suspend', 'on-resume', 'on-ac', 'on-battery';

plan @methods.elems + 1;

use Atom::Electron::PowerMonitor;
ok 1, "'use Atom::Electron::PowerMonitor' worked!";

for @methods -> $method {
  ok Atom::Electron::PowerMonitor.can($method), "PowerMonitor.$method is found";
}
