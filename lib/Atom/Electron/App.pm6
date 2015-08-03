=begin pod
  This is the screen API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/app.md

  TODO implement remaining parts of Atom::Electron::App
=end pod
class Atom::Electron::App {

  use File::Which;
  use JSON::RPC::Client;

  has $!electron_process;
  has @!listeners;

  # Singleton instance
  my Atom::Electron::App $instance;

  # The JSON RPC client
  my JSON::RPC::Client $json-rpc;

  # No constructor allowed
  method new {
    !!!
  }
  
=begin pod
  The singleton instance of the Electron App.
  Please note that App.new will die by design
=end pod
  method instance { 
    if ! $instance.defined {
      $instance = Atom::Electron::App.bless;
      $instance.initialize;
    }
    $instance;
  }
  
=begin pod
  The JSON RPC Client
=end pod
  method json-rpc {
    return $json-rpc;
  }

=begin pod
  Internal method to initialize electron process along with JSON RPC client
=end pod
  submethod initialize {
    unless $!electron_process {
      fail("Cannot find electron in PATH") unless which('electron');

      $!electron_process = Proc::Async.new( "electron", "lib/Atom/Electron/main_app" );
      $!electron_process.start;
      sleep 1;

      unless $json-rpc {
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
         $json-rpc = JSON::RPC::Client.new( transport => &transport );
      }
    }
  }

=begin pod
  Destroy the singleton App by quitting it, sleeping a bit and
  then force killing the electron process
=end pod
  method destroy {
    $json-rpc.App-quit;
    sleep 0.5;
    if $!electron_process.defined {
      $!electron_process.kill(SIGTERM);
    }
  }
  
=begin pod
  Start processing and dispatching events. It also blocks the current thread.
=end pod
  method event-loop {

    loop {
      # Process pending events indefinity
      my $o = $.json-rpc.get-pending-events;
      for @($o<events>) -> $event {
        for @!listeners -> $listener {
          next if $listener<id>.defined && $listener<id> != $event<id>;
          next if $listener<name> ne $event<name>;
          $listener<listener>();
        }
      }

      # Sleep a bit to prevent 100% CPU usage
      sleep 0.05;
    }
  }

=begin pod
  Registers an event listener
=end pod
  method on(:$name, :$id, :$listener) {
    @!listeners.push({
      "id"        => $id,
      "name"      => $name,
      "listener"  => $listener
    });
  }
}
