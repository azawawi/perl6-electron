use JSON::RPC::Client;

class Atom::Electron::App {
  has $!pc;
  has @!listeners;

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
         sub transport ( Str :$json, Bool :$get_response ) {
           my $t = LWP::Simple.post(
             'http://127.0.0.1:3333',
             {
               'Content-Type' => 'application/json'
             },
             $json);
           return $t.decode('utf-8');
         }
         $json-client = JSON::RPC::Client.new( transport => &transport );
      }
    }
  }
  
  method destroy {
    if $!pc.defined {
      $!pc.kill;
    }
  }
  
  method event_loop {
    loop {
      my $o = $.json-client.get_pending_events;
      my @events = @($o<events>);
      for @events -> $event {
        for @!listeners -> $listener {
          next if $listener<handle> != $event<handle>;
          next if $listener<event_name> ne $event<event_name>;
          $listener<listener>();
        }
      }
      sleep 0.5;
    }
  }

  method on(:$event_name, :$handle, :$listener) {
    @!listeners.push({handle => $handle, event_name => $event_name, listener => $listener});
  }
}
