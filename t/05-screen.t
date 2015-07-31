use v6;

use Test;

use lib 'lib';

# Methods to test
my @methods = 'on', 'get_cursor_screen_point', 'get_primary_display', 'get_all_displays',
  'get_display_nearest_point', 'get_display_matching';

plan @methods.elems + 12;

use Atom::Electron::Screen;
ok 1, "'use Atom::Electron::Screen' worked!";

for @methods -> $method {
  ok Atom::Electron::Screen.can($method), "Screen.$method is found";
}

{
  # Skip tests if the electron executable is not found
  use File::Which;
  unless which('electron') {
    skip-rest("electron is not installed. skipping tests...");
    exit;
  }
}

my $app = Atom::Electron::App.instance;
LEAVE {
  diag 'Destroy electron app';
  $app.destroy;
}


my $o = Atom::Electron::Screen.get_cursor_screen_point;
ok $o<x>.defined, "x hash key found";
ok $o<y>.defined, "y hash key found";

$o = Atom::Electron::Screen.get_primary_display;
ok $o<bounds>.defined, "bounds hash key found";
ok $o<bounds><x>.defined, "bounds.x hash key found";

$o = Atom::Electron::Screen.get_all_displays;
ok $o.elems > 0, "Array with at least one screen";
ok $o[0]<bounds>.defined, "bounds hash key found for the first screen";
ok $o[0]<bounds><x>.defined, "bounds.x hash key found for the first screen";

$o = Atom::Electron::Screen.get_display_nearest_point({x => 0, y => 0});
ok $o<bounds>.defined, "bounds hash key found";
ok $o<bounds><x>.defined, "bounds.x hash key found";

$o = Atom::Electron::Screen.get_display_matching(
  {x => 0, y => 0, width => 640, height => 480}
);
ok $o<bounds>.defined, "bounds hash key found";
ok $o<bounds><x>.defined, "bounds.x hash key found";
