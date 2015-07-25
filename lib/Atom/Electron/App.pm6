class Atom::Electron::App {
  method bridge {
    my $pc = Proc::Async.new( "electron", "lib/Atom/Electron/main_app" );
    $pc.start;

    say "Sleeping in Perl 6 land";
    sleep 10;
    say "Bye bye from Perl 6 land";
  }
}
