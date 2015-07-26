class Atom::Electron::App {
  has $!pc;

  method bridge {
    if !$!pc {
      $!pc = Proc::Async.new( "electron", "lib/Atom/Electron/main_app" );
      $!pc.start;
      sleep 2;
    }
  }
  
  method unbridge {
    if $!pc.defined {
      say "Killing electron!";
      $!pc.kill;
    }
  }
}
