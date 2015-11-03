use v6;

use Test;



# Methods to test
my @methods = 'on', 'on-suspend', 'on-resume', 'on-ac', 'on-battery';

plan @methods.elems + 1;

use Electron::PowerMonitor;
ok 1, "'use Electron::PowerMonitor' worked!";

for @methods -> $method {
  ok Electron::PowerMonitor.can($method), "PowerMonitor.$method is found";
}
