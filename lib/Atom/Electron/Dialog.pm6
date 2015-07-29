=begin pod
  This is the dialog API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/dialog.md

  The dialog API wrapper provides methods to show native system dialogs,
  so web applications can deliver the same user experience as native
  applications.

  An example of showing a dialog to select multiple files and directories:

    use Atom::Electron::Dialog;
    my $win = ...;  // window in which to show the dialog
    say Atom::Electron::Dialog.show_open_dialog(
      :properties( [ 'openFile', 'openDirectory', 'multiSelections' ] )
    );

    Note for OS X: If you want to present dialogs as sheets, the only thing you
    have to do is provide a BrowserWindow reference in the browserWindow
    parameter.
=end pod
class Atom::Electron::Dialog {

  use Atom::Electron::App;

=begin pod
  
=end pod
  method show_open_dialog() {
    !!!
    my $result = Atom::Electron::App.json-client.Dialog-show_open_dialog();
    return $result<text>;
  }

=begin pod
  
=end pod
  method show_save_dialog() {
    !!!
    Atom::Electron::App.json-client.Dialog-show_save_dialog();
    return;
  }

=begin pod
=end pod
  method show_message_box() {
    !!!
    Atom::Electron::App.json-client.Dialog-show_message_box();
    return;
  }

=begin pod
  Runs a modal dialog that shows an error message.
  This API can be called safely before the ready event of app module emits,
  it is usually used to report errors in early stage of startup.
=end pod
  method show_error_box(Str $text, Str $content) {
    Atom::Electron::App.json-client.Dialog-show_error_box(
      :text($text), :content($content)
    );
    return;
  }

}