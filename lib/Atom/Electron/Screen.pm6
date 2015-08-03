=begin pod
  This is the screen API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/screen.md
=end pod
class Atom::Electron::Screen {

  use Atom::Electron::App;

=begin pod
  Register an event listener
TODO implement
=end pod
  method on($name, $listener) {
    !!!
    return;
  }

=begin pod
  Registers an event that fired when a new display is added.

    event Event
    newDisplay Object
=end pod
  method on-display-added($listener) {
    self.on-display-added($listener);
  }

=begin pod
  Registers an event that is fired when an old display is removed.
=end pod
  method on-display-removed($listener) {
    self.on('displayed-removed', $listener);
  }

=begin pod
  Registers an event that is fired when a display has one or more metrics
  changed

  - display Object
  - changedMetrics Array

  changedMetrics is an array of strings that describe the changes.
  Possible changes are bounds, workArea, scaleFactor and rotation.
=end pod
method on-display-metrics-changed($listener) {
  self.on('display-metrics-changed', $listener);
}

=begin pod
  Returns the current absolute position of the mouse pointer.
=end pod
  method get_cursor_screen_point {
    return Atom::Electron::App.json-rpc.Screen-get_cursor_screen_point<result>;
  }

=begin pod
  Returns the primary display.
=end pod
  method get_primary_display {
    return Atom::Electron::App.json-rpc.Screen-get_primary_display<result>;
  }

=begin pod
  Returns an array of displays that are currently available.
=end pod
  method get-all-displays {
    return Atom::Electron::App.json-rpc.Screen-get-all-displays<result>;
  }

=begin pod
  Returns the display nearest the specified point.
  point is a hash
    Int x
    Int y
=end pod
  method get-display-nearest-point($point) {
    return Atom::Electron::App.json-rpc.Screen-get-display-nearest-point(point => $point)<result>;
  }

=begin pod
  Returns the display that most closely intersects the provided bounds.
    rect is a hash object
      Int x
      Int y
      Int width
      Int height
=end pod
  method get-display-matching($rect) {
    return Atom::Electron::App.json-rpc.Screen-get-display-matching(rect => $rect)<result>;
  }
}
