use v6;

use Test;

use lib 'lib';

# Methods to test
my @methods = 'on', 'get_cursor_screen_point', 'get_primary_display', 'get_all_displays',
  'get_display_nearest_point', 'get_display_matching';

plan @methods.elems + 1;

use Atom::Electron::Screen;
ok 1, "'use Atom::Electron::Screen' worked!";

for @methods -> $method {
  ok Atom::Electron::Screen.can($method), "Screen.$method is found";
}
