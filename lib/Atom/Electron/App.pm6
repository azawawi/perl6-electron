use JSON::RPC::Client;

=begin pod
  This is the screen API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/app.md

  TODO implement remaining parts of Atom::Electron::App
=end pod
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
  
=begin pod
  TODO document
=end pod
  # App.instance
  method instance { 
    if ! $instance.defined {
      $instance = Atom::Electron::App.bless;
      $instance.initialize;
    }
    $instance;
  }
  
=begin pod
  TODO document
=end pod
  method json-client {
    return $json-client;
  }

=begin pod
TODO document
=end pod
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
  
=begin pod
  Destroy the singleton App by quitting it, sleeping a bit and
  then force killing the electron process
=end pod
  method destroy {
    $json-client.App-quit;
    sleep 0.5;
    if $!pc.defined {
      $!pc.kill(SIGTERM);
    }
  }
  
=begin pod
  TODO document
=end pod
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
