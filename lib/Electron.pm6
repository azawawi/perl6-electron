use v6;

=begin pod

This will use all the Electron::* API namespace and is intended for
shorter code or if you are actually using all API :).

For faster scripts, it is advised to use the API that you only need.
=end pod
unit class Electron;

use Electron::App;
use Electron::BrowserWindow;
use Electron::Clipboard;
use Electron::Dialog;
use Electron::Menu;
use Electron::PowerMonitor;
use Electron::Process;
use Electron::Screen;
use Electron::Shell;
use Electron::Tray;

