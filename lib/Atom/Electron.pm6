use v6;

=begin pod

This will use all the Atom::Electron::* API namespace and is intended for
shorter code or if you are actually using all API :).

For faster scripts, it is advised to use the API that you only need.
=end pod
class Atom::Electron {
  use Atom::Electron::App;
  use Atom::Electron::BrowserWindow;
  use Atom::Electron::Clipboard;
  use Atom::Electron::Dialog;
  use Atom::Electron::Menu;
  use Atom::Electron::PowerMonitor;
  use Atom::Electron::Process;
  use Atom::Electron::Screen;
  use Atom::Electron::Shell;
  use Atom::Electron::Tray;
}
