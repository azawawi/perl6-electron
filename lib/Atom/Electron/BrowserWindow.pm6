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

  has Int $!handle_id;
  has Int $.width;
  has Int $.height;
  has Bool $.dev_tools_enabled;
  has Bool $.show;

  submethod BUILD(
     :$!width = 800,
     :$!height = 600,
     :$!dev_tools_enabled = False,
   ) {
     my $result = $json-client.BrowserWindow-new(
       width => $!width, 
       height => $!height, 
       dev_tools_enabled => $!dev_tools_enabled
     );
     if $result.defined {
       say $result.perl;
       $!handle_id = $result;
     } 
  }
  
  method load_url(Str $url) {
    $json-client.BrowserWindow-load_url(handle_id => $!handle_id, url => $url);
	}

	method on($event_name, $listener) {
		say "BrowserWindow.on...";
		#add-listener($event-name, $listener);
	}

	method show {
		#Atom::Electron::JSONBridged.call_js('BrowserWindow-show');
	}

}
