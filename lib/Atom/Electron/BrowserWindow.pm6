# JSON Client!
use Atom::Electron::App;

#
# Wrap browser-window API
# Please see:
# https://github.com/atom/electron/blob/master/docs/api/browser-window.md
# https://github.com/atom/electron/blob/master/docs/api/frameless-window.md
#
class Atom::Electron::BrowserWindow {

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
  
  method load_url(Str $url) {
    Atom::Electron::App.json-client.BrowserWindow-load_url(handle => $!handle, url => $url);
    return;
	}

	method on($event_name, $listener) {
    Atom::Electron::App.json-client.BrowserWindow-on(handle => $!handle, event_name => $event_name);
    return;
	}

	method show {
    Atom::Electron::App.json-client.BrowserWindow-show(handle => $!handle);
    return;
	}

}
