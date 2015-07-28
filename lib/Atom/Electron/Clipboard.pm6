use Atom::Electron::App;

=begin pod
  This is the clipboard API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/clipboard.md

  NOTE: Please note that not all the clipboard API was wrapped

  The clipboard API wrapper provides methods to do copy/paste operations.
  An example of writing a string to clipboard:

    use Atom::Electron::Clipboard;
    Atom::Electron::Clipboard.write_text('Example String');

  On X Window systems, there is also a selection clipboard, to manipulate in it
  you need to pass selection to each method:

    use Atom::Electron::Clipboard;
    Atom::Electron::Clipboard.write_text('Example String', 'selection');
    say Atom::Electron::Clipboard.read_text('selection');

=end pod
class Atom::Electron::Clipboard {

=begin pod
  Returns the content in clipboard as plain text.
=end pod
  method read_text(Str $type?) {
    my $result = Atom::Electron::App.json-client.Clipboard-read_text(type => $type);
    return $result<text>;
  }

=begin pod
  Returns the content in clipboard as plain text.
=end pod
  method write_text(Str $text, Str $type?) {
    Atom::Electron::App.json-client.Clipboard-write_text(text => $text, type => $type);
    return;
  }

=begin pod
  Clears everything in clipboard.
=end pod
  method clear {
    Atom::Electron::App.json-client.Clipboard-clear;
    return;
  }

}