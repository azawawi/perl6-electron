use v6;

use Test;



# Methods to test
my @methods = 'on', 'on-display-added', 'on-display-removed',
  'on-display-metrics-changed', 'get_cursor_screen_point',
  'get_primary_display', 'get-all-displays', 'get-display-nearest-point',
  'get-display-matching';

plan @methods.elems + 12;

use Electron::Screen;
ok 1, "'use Electron::Screen' worked!";

for @methods -> $method {
  ok Electron::Screen.can($method), "Screen.$method is found";
}

{
  # Skip tests if the electron executable is not found
  use File::Which;
  unless which('electron') {
    skip-rest("electron is not installed. skipping tests...");
    exit;
  }
}

my $app = Electron::App.instance;
LEAVE {
  diag 'Destroy electron app';
  $app.destroy;
}


my $o = Electron::Screen.get_cursor_screen_point;
ok $o<x>.defined, "x hash key found";
ok $o<y>.defined, "y hash key found";

$o = Electron::Screen.get_primary_display;
ok $o<bounds>.defined, "bounds hash key found";
ok $o<bounds><x>.defined, "bounds.x hash key found";

$o = Electron::Screen.get-all-displays;
ok $o.elems > 0, "Array with at least one screen";
ok $o[0]<bounds>.defined, "bounds hash key found for the first screen";
ok $o[0]<bounds><x>.defined, "bounds.x hash key found for the first screen";

$o = Electron::Screen.get-display-nearest-point({x => 0, y => 0});
ok $o<bounds>.defined, "bounds hash key found";
ok $o<bounds><x>.defined, "bounds.x hash key found";

$o = Electron::Screen.get-display-matching(
  {x => 0, y => 0, width => 640, height => 480}
);
ok $o<bounds>.defined, "bounds hash key found";
ok $o<bounds><x>.defined, "bounds.x hash key found";
