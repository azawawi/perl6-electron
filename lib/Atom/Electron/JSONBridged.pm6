
role Atom::Electron::JSONBridged {

  use JSON::RPC::Client;

  has $!json-client;

  method call_js($method_name, $args) {
    if !$!json-client {
         # create new client with url to server
         $!json-client = JSON::RPC::Client.new( url => 'http://localhost:8080' );
    }

    say "Calling $method_name";
    $!json-client.$method_name($args);
  }
}
