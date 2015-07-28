use Atom::Electron::App;

=begin pod
  The shell module Perl 6 API Wrapper described in
  https://github.com/atom/electron/blob/master/docs/api/shell.md

  The shell module provides functions related to desktop integration. 
  An example of opening a URL in default browser:

    var shell = require('shell');
    shell.openExternal('https://github.com');

=end pod
class Atom::Electron::Shell {

=begin pod
    Show the given file in a file manager. If possible, select the file.
=end pod
  method show_item_in_folder(Str $full_path) {
    Atom::Electron::App.json-client.Shell-show_item_in_folder(full_path => $full_path);
    return;
  }

=begin pod
    Open the given file in the desktop's default manner.
=end pod
  method open_item(Str $full_path) {
    Atom::Electron::App.json-client.Shell-open_item(full_path => $full_path);
    return;
  }

=begin pod
    Open the given external protocol URL in the desktop's default manner. 
    (For example, mailto: URLs in the default mail user agent.)
=end pod
  method open_external(Str $url) {
    Atom::Electron::App.json-client.Shell-open_external(url => $url);
    return;
  }

=begin pod
    Move the given file to trash and returns boolean status for the operation.
=end pod
  method move_item_to_trash(Str $full_path) {
    Atom::Electron::App.json-client.Shell-move_item_to_trash(full_path => $full_path);
    return;
  }

=begin pod
    Play the beep sound.
=end pod
  method beep {
    Atom::Electron::App.json-client.Shell-beep;
    return;
  }

}