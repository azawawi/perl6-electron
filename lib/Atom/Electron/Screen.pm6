=begin pod
  This is the screen API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/screen.md
=end pod
class Atom::Electron::Screen {

    use Atom::Electron::App;

=begin pod
  Register an event listener
TODO implement Screen.on(...)
=end pod
  method on($event_name, $listener) {
    !!!
    #Atom::Electron::App.json-client.Screen-on(handle => $!handle, event_name => $event_name);
    #Atom::Electron::App.instance.on(handle => $!handle, event_name => $event_name, listener => $listener);
    return;
  }

=begin pod
  Returns the current absolute position of the mouse pointer.
=end pod
  method get_cursor_screen_point {
    return Atom::Electron::App.json-client.Screen-get_cursor_screen_point;
  }

=begin pod
  Returns the primary display.
=end pod
  method get_primary_display {
    return Atom::Electron::App.json-client.Screen-get_primary_display;
  }

=begin pod
  Returns an array of displays that are currently available.
=end pod
  method get_all_displays {
    return Atom::Electron::App.json-client.Screen-get_all_displays;
  }

=begin pod
  Returns the display nearest the specified point.
  point is a hash
    Int x
    Int y
=end pod
  method get_display_nearest_point($point) {
    return Atom::Electron::App.json-client.Screen-get_display_nearest_point(point => $point);
  }

=begin pod
  Returns the display that most closely intersects the provided bounds.
    rect is a hash object
      Int x
      Int y
      Int width
      Int height
=end pod
  method get_display_matching($rect) {
    return Atom::Electron::App.json-client.Screen-get_display_matching(rect => $rect);
  }
}
