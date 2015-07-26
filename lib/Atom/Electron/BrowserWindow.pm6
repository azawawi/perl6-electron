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

class Atom::Electron::BrowserWindow {

  has Int $.handle_id is rw;
  has Int $.width = 800;
  has Int $.height = 600;
  has Bool $.dev_tools_enabled = False;
  has Bool $.show;

  method new {
    my $o = self.bless;
    
    say $o.perl;
    my $result = $json-client.BrowserWindow-new(
      width => $o.width, 
      height => $o.height, 
      dev_tools_enabled => $o.dev_tools_enabled
    );
    if $result.defined {
      say "handle id is $($result:handle_id)";
      $o.handle_id = +$result:handle_id;
    }
    return $o;
  }

	method on($event_name, $listener) {
		say "BrowserWindow.on...";
		#add-listener($event-name, $listener);
	}

	method load_url(Str $url) {
    $json-client.BrowserWindow-load_url(handle_id => $!handle_id, url => $url);
	}

	method show {
		#Atom::Electron::JSONBridged.call_js('BrowserWindow-show');
	}

}
