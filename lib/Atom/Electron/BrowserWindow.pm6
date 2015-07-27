# JSON Client!
use JSON::RPC::Client;

my $json-client;
sub init_js is export {
  if ! $json-client {
     # create new client with url to server
     say "Creating js client";
     my $url = 'http://localhost:8080';
     sub transport ( Str :$json, Bool :$get_response ) {
       my $t = LWP::Simple.post( ~$url, { 'Content-Type' => 'application/json' }, $json );
       return $t.decode('utf-8');
     }
      $json-client = JSON::RPC::Client.new( transport => &transport );
  }
}

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
     my $result = $json-client.BrowserWindow-new(
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
    $json-client.BrowserWindow-load_url(handle => $!handle, url => $url);
    return;
	}

	method on($event_name, $listener) {
    $json-client.BrowserWindow-on(event_name => $event_name);
    return;
	}

	method show {
    $json-client.BrowserWindow-show;
    return;
	}

}
