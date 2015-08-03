=begin pod
  This is the shell API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/shell.md

  The shell API wrapper provides functions related to desktop integration.
  An example of opening a URL in default browser:

    use Atom::Electron::Shell;
    Atom::Electron::Shell.open-external("http://doc.perl6.org");

=end pod
class Atom::Electron::Shell {

  use Atom::Electron::App;

=begin pod
  Show the given file in a file manager. If possible, select the file.
=end pod
  method show-item-in-folder(Str $full_path) {
    Atom::Electron::App.json-rpc.Shell-show-item-in-folder(full_path => $full_path);
    return;
  }

=begin pod
  Open the given file in the desktop's default manner.
=end pod
  method open-item(Str $full_path) {
    Atom::Electron::App.json-rpc.Shell-open-item(full_path => $full_path);
    return;
  }

=begin pod
  Open the given external protocol URL in the desktop's default manner. 
  (For example, mailto: URLs in the default mail user agent.)
=end pod
  method open-external(Str $url) {
    Atom::Electron::App.json-rpc.Shell-open-external(url => $url);
    return;
  }

=begin pod
  Move the given file to trash and returns boolean status for the operation.
=end pod
  method move-item-to-trash(Str $full_path) {
    Atom::Electron::App.json-rpc.Shell-move-item-to-trash(full_path => $full_path);
    return;
  }

=begin pod
  Play the beep sound.
=end pod
  method beep {
    Atom::Electron::App.json-rpc.Shell-beep;
    return;
  }

}