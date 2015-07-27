use JSON::RPC::Client;

class Atom::Electron::App {
  has $!pc;
  
  # singleton instance
  my Atom::Electron::App $instance;
  my JSON::RPC::Client $json-client;

  # No constructor allowed
  method new {
    # Singleton.new dies.
    !!!
  }
  
  # App.instance
  method instance { 
    if ! $instance.defined {
      $instance = Atom::Electron::App.bless;
      $instance.initialize;
    }
    $instance;
  }
  
  method json-client {
    return $json-client;
  }

  submethod initialize {
    if !$!pc {
      $!pc = Proc::Async.new( "electron", "lib/Atom/Electron/main_app" );
      $!pc.start;
      sleep 2;

      if ! $json-client {
         # create new client with url to server
         my $url = 'http://localhost:8080';
         sub transport ( Str :$json, Bool :$get_response ) {
           my $t = LWP::Simple.post( ~$url, { 'Content-Type' => 'application/json' }, $json );
           return $t.decode('utf-8');
         }
          $json-client = JSON::RPC::Client.new( transport => &transport );
      }
    }
  }
  
  method destroy {
    if $!pc.defined {
      say "Killing electron!";
      $!pc.kill;
    }
  }
  
  method event_loop {
    say "Event loop started";
    loop {
      my $result = $.json-client.get_pending_events();
      sleep 0.5;
    }
  }
}
