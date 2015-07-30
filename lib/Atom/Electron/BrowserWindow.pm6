=begin pod
  This is the browser window API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/browser-window.md
  and
  https://github.com/atom/electron/blob/master/docs/api/frameless-window.md

  TODO implement remaining parts of Atom::Electron::BrowserWindow
=end pod
class Atom::Electron::BrowserWindow {

  use Atom::Electron::App;

  has Int $!handle;
  has Int $.x;
  has Int $.y;
  has Int $.width;
  has Int $.height;
  has Bool $.dev_tools_enabled;
  has Bool $.frame;
  has Bool $.transparent;
  has Bool $.show;
  has Bool $.kiosk;

=begin pod
TODO document
=end pod
  submethod BUILD(
     :$!x = 0,
     :$!y = 0,
     :$!width = 800,
     :$!height = 600,
     :$!dev_tools_enabled = False,
     :$!frame = True,
     :$!transparent = False,
     :$!show        = True,
     :$!kiosk       = False,
   ) 
   {
     my $result = Atom::Electron::App.json-client.BrowserWindow-new(
       x                 => $!x,
       y                 => $!y,
       width             => $!width, 
       height            => $!height, 
       dev_tools_enabled => $!dev_tools_enabled,
       frame             => $!frame,
       transparent       => $!transparent,
       show              => $!show,
       kiosk             => :$!kiosk,
     );
     if $result.defined {
       $!handle = $result;
     } else {
       # TODO invalid response. throw exception?
     }
  }
  
=begin pod
TODO document
=end pod
  method load_url(Str $url) {
    Atom::Electron::App.json-client.BrowserWindow-load_url(handle => $!handle, url => $url);
    return;
  }

=begin pod
TODO document
=end pod
  method on($event_name, $listener) {
    Atom::Electron::App.json-client.BrowserWindow-on(handle => $!handle, event_name => $event_name);
    Atom::Electron::App.instance.on(handle => $!handle, event_name => $event_name, listener => $listener);
    return;
  }

=begin pod
TODO document
=end pod
  method show {
    Atom::Electron::App.json-client.BrowserWindow-show(handle => $!handle);
    return;
  }

}
