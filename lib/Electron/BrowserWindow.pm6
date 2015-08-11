=begin pod
  This is the browser window API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/browser-window.md
  and
  https://github.com/atom/electron/blob/master/docs/api/frameless-window.md

  TODO implement remaining parts of Electron::BrowserWindow
=end pod
unit class Electron::BrowserWindow;

use Electron::App;

has Int $!handle;
has Int $.x;
has Int $.y;
has Int $.width;
has Int $.height;
has Bool $.dev_tools_enabled;
has Bool $.frame;
has Bool $.transparent;
has Bool $.show;
has Bool $.kiosk;

=begin pod
TODO document
=end pod
submethod BUILD(
   :$!x = 0,
   :$!y = 0,
   :$!width = 800,
   :$!height = 600,
   :$!dev_tools_enabled = False,
   :$!frame = True,
   :$!transparent = False,
   :$!show        = True,
   :$!kiosk       = False,
 ) 
 {
   my $result = Electron::App.json-rpc.BrowserWindow-new(
     x                 => $!x,
     y                 => $!y,
     width             => $!width, 
     height            => $!height, 
     dev_tools_enabled => $!dev_tools_enabled,
     frame             => $!frame,
     transparent       => $!transparent,
     show              => $!show,
     kiosk             => :$!kiosk,
   );
   if $result.defined {
     $!handle = $result;
   } else {
     # TODO invalid response. throw exception?
   }
}

=begin pod
TODO document
=end pod
method load-url(Str $url) {
  Electron::App.json-rpc.BrowserWindow-load-url(handle => $!handle, url => $url);
  return;
}

=begin pod
TODO document
=end pod
method on($name, $listener) {
  Electron::App.json-rpc.BrowserWindow-on(handle => $!handle, name => $name);
  Electron::App.instance.on(handle => $!handle, name => $name, listener => $listener);
  return;
}

=begin pod
TODO document
=end pod
method show {
  Electron::App.json-rpc.BrowserWindow-show(handle => $!handle);
  return;
}

=begin pod
Registers an event that the document changed its title

calling event.preventDefault() would prevent the native window's title to
change.
=end pod
method on-page-title-updated($listener) {
  self.on('page-title-updated', $listener);
}

=begin pod
Registers an event that the document changed its title

Emitted when the window is going to be closed. It's emitted before the
beforeunload and unload event of DOM, calling $event.prevent-default
would cancel the close.

Usually you would want to use the beforeunload handler to decide whether
the window should be closed, which will also be called when the window
is reloaded. In Electron, returning an empty string or false would cancel
the close. An example is:

window.onbeforeunload = sub($e) {
  say 'I do not want to be closed';

  # Unlike usual browsers, in which a string should be returned and the user is
  # prompted to confirm the page unload, Electron gives developers more options.
  # Returning empty string or false would prevent the unloading now.
  # You can also use the dialog API to let the user confirm closing the application.
  return False;
};

=end pod
method on-close($listener) {
  self.on-close($listener);
}

=begin pod
Registers an event that is fired when the window is closed. After you have
received this event you should remove the reference to the window and avoid
using it anymore.
=end pod
method on-closed($listener) {
  self.on('closed', $listener);
}

=begin pod
Registers an event that fired when the the web page becomes unresponsive.
=end pod
method on-unresponsive($listener) {
  self.on('unresponsive', $listener);
}

=begin pod
Registers an event that fired when the the web page becomes responsive.
=end pod
method on-responsive($listener) {
  self.on('responsive', $listener);
}

=begin pod
Registers an event that fired when the window loses focus.
=end pod
method on-blur($listener) {
  self.on('blur', $listener);
}

=begin pod
Registers an event that fired when the window gains focus.
=end pod
method on-focus($listener) {
  self.on('focus', $listener);
}

=begin pod
Registers an event that fired when the window is maximized
=end pod
method on-maximize($listener) {
  self.on('maximize', $listener);
}

=begin pod
Registers an event that fired when the window exits from maximized state.
=end pod
method on-unmaximize($listener) {
  self.on('unmaximize', $listener);
}

=begin pod
Registers an event that fired when the window is minimized
=end pod
method on-minimize($listener) {
  self.on('minimize', $listener);
}

=begin pod
Registers an event that fired when the window is restored from minimized
state.
=end pod
method on-restore($listener) {
  self.on('restore', $listener);
}

=begin pod
Registers an event that fired when the window is is getting resized
=end pod
method on-resize($listener) {
  self.on('resize', $listener);
}

=begin pod
Registers an event that fired when the window is getting moved to a new
position

Note: On OS X this event is just an alias of moved.
=end pod
method on-move($listener) {
  self.on('move', $listener);
}

=begin pod
Registers an event that fired when the window is moved to a new position.

Note: This event is available only on OS X.
=end pod
method on-moved($listener) {
  self.on('moved', $listener);
}

=begin pod
Registers an event that fired when the window enters full screen state.
=end pod
method on-enter-full-screen($listener) {
  self.on('enter-full-screen', $listener);
}

=begin pod
Registers an event that fired when the window leaves full screen state.

Note: This event is available only on OS X.
=end pod
method on-leave-full-screen($listener) {
  self.on('leave-full-screen', $listener);
}

=begin pod
Registers an event that fired when the window enters full screen state
triggered by html api.
=end pod
method on-enter-html-full-screen($listener) {
  self.on('enter-html-full-screen', $listener);
}

=begin pod
Registers an event that fired when the window leaves full screen state
triggered by html api.
=end pod
method on-leave-html-full-screen($listener) {
  self.on('leave-html-full-screen', $listener);
}

=begin pod
Registers an event that fired when the devtools is opened.
=end pod
method on-devtools-opened($listener) {
  self.on('devtools-opened', $listener);
}

=begin pod
Registers an event that fired when the devtools is closed.
=end pod
method on-devtools-closed($listener) {
  self.on('devtools-closed', $listener);
}

=begin pod
Registers an event that fired when the devtools is focused / opened.
=end pod
method on-devtools-focused($listener) {
  self.on('devtools-focused', $listener);
}

=begin pod
Registers an event that fired when an App Command is invoked. These are
typically related to keyboard media keys or browser commands, as well as the
"Back" button built into some mice on Windows.

  $win.on-app-command(sub($e, $cmd) {
    # Navigate the window back when the user hits their mouse back button
    if ($cmd === 'browser-backward' && $win.web_contents.can_go_back) {
      $win.webContents.go_back;
    }
  });

  Note: This event is only fired on Windows.
=end pod
method on-app-command($listener) {
  self.on('app-command', $listener);
}

