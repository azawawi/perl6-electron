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

TODO implement callback via event loop

Opens the open file dialog with the following options:

browserWindow BrowserWindow
options Object
title String
defaultPath String
filters Array
properties Array - Contains which features the dialog should use, can contain openFile, openDirectory, multiSelections and createDirectory
callback Function
On success, returns an array of file paths chosen by the user, otherwise returns undefined.

The filters specifies an array of file types that can be displayed or selected, an example is:

    {
      filters: [
        { name: 'Images', extensions: ['jpg', 'png', 'gif'] },
        { name: 'Movies', extensions: ['mkv', 'avi', 'mp4'] },
        { name: 'Custom File Type', extensions: ['as'] }
      ]
    }
If a callback is passed, the API call would be asynchronous and the result would be passed via callback(filenames)

Note: On Windows and Linux, an open dialog can not be both a file selector and a directory selector, so if you set properties to ['openFile', 'openDirectory'] on these platforms, a directory selector will be shown.
=end pod
  method show_open_dialog(:$browserWindow = Nil, :$options = {}) {
    my $handle = $browserWindow.defined ?? $browserWindow.handle !! -1;
    my $result = Atom::Electron::App.json-client.Dialog-show_open_dialog(
      handle   => $handle,
      options  => $options
    );
    return $result<selected>;
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