use v6;

class Atom::Electron {
}


class Atom::Electron::App {
  use JSON::RPC::Server;

  has $!json_bridge_server;

  method bridge {
    my $pc = Proc::Async.new( "electron", "lib/Atom/Electron/main_app" );
    $pc.start;

    # This will handle JSON remote procedure calls
    class My::JSON::RPC::Bridge {

       method init {
         say "Got an init request from main.js";

         return %(
           width     => 1024,
           height    => 400,
           dev_tools => False,
         );
       }

       method stop {
         say "Stopping main Perl 6 process";
         $pc.kill;
         exit 1;

         return;
       }
    }

    # start server with your application as handler
    say "Starting the JSON::RPC bridge";
    $!json_bridge_server = JSON::RPC::Server.new( application => My::JSON::RPC::Bridge );
    $!json_bridge_server.run;
  }
}

class Atom::Electron::BrowserWindow {
  has Int $!width;
  has Int $!height;
  has Bool $!dev_tools_enabled;
  has Str $!home_dir;
}

#  use Atom::Electron::App;
#  use Atom::Electron::BrowserWindow;
#
#  my $app = Atom::Electron::App.new.bridge;
#  $app.on('ready', sub {
#    my $win = Atom::Electron::BrowserWindow.new;
#    $win.on('ready', sub {
#      "Window open!".say;
#    });
#
#    $win.on('closed', sub {
#      "Window closed!".say;
#    });
#  });
