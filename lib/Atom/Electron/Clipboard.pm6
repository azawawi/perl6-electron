=begin pod
  This is the clipboard API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/clipboard.md

  NOTE: Please note that not all the clipboard API was wrapped

  The clipboard API wrapper provides methods to do copy/paste operations.
  An example of writing a string to clipboard:

    use Atom::Electron::Clipboard;
    Atom::Electron::Clipboard.write-text('Example String');

  On X Window systems, there is also a selection clipboard, to manipulate in it
  you need to pass selection to each method:

    use Atom::Electron::Clipboard;
    Atom::Electron::Clipboard.write-text('Example String', 'selection');
    say Atom::Electron::Clipboard.read-text('selection');

    TODO implement remaining parts of Atom::Electron::Clipboard
=end pod
class Atom::Electron::Clipboard {

  use Atom::Electron::App;

=begin pod
  Returns the content in clipboard as plain text.
=end pod
  method read-text(Str $type?) {
    my $result = Atom::Electron::App.json-rpc.Clipboard-read-text(type => $type);
    return $result<text>;
  }

=begin pod
  Returns the content in clipboard as plain text.
=end pod
  method write-text(Str $text, Str $type?) {
    Atom::Electron::App.json-rpc.Clipboard-write-text(text => $text, type => $type);
    return;
  }

=begin pod
  Clears everything in clipboard.
=end pod
  method clear {
    Atom::Electron::App.json-rpc.Clipboard-clear;
    return;
  }

}