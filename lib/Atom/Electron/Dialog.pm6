=begin pod
  This is the dialog API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/dialog.md

  The dialog API wrapper provides methods to show native system dialogs,
  so web applications can deliver the same user experience as native
  applications.

  An example of showing a dialog to select multiple files and directories:

    use Atom::Electron::Dialog;
    my $win = ...;  // window in which to show the dialog
    say Atom::Electron::Dialog.show-open-dialog(
      :properties( [ 'openFile', 'openDirectory', 'multiSelections' ] )
    );

    Note for OS X: If you want to present dialogs as sheets, the only thing you
    have to do is provide a BrowserWindow reference in the browserWindow
    parameter.
=end pod
class Atom::Electron::Dialog {

  use Atom::Electron::App;

=begin pod
  Opens the open file dialog with the following options:

  TODO implement callback via event loop

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
  method show-open-dialog(:$browserWindow = Nil, :$options = {}) {
    my $handle = $browserWindow.defined ?? $browserWindow.handle !! -1;
    my $result = Atom::Electron::App.json-rpc.Dialog-show-open-dialog(
      handle   => $handle,
      options  => $options
    );
    return $result<selected>;
  }

=begin pod
  Opens the save file dialog with the following options:

  TODO implement callback via event loop

  browserWindow BrowserWindow
  options Object
  title String
  defaultPath String
  filters Array
  callback Function
  On success, returns the path of the file chosen by the user, otherwise returns undefined.

  The filters specifies an array of file types that can be displayed, see dialog.showOpenDialog for an example.

  If a callback is passed, the API call will be asynchronous and the result will be passed via callback(filename
=end pod
  method show-save-dialog(:$browserWindow = Nil, :$options = {}) {
    my $handle = $browserWindow.defined ?? $browserWindow.handle !! -1;
    my $result = Atom::Electron::App.json-rpc.Dialog-show-save-dialog(
      handle   => $handle,
      options  => $options
    );
    return $result<selected>;
  }

=begin pod
  Show a message box

  TODO implement callback via event loop

  browserWindow BrowserWindow
  options Object
  type String - Can be "none", "info", "error", "question" or "warning". On Windows, "question" displays the same icon as "info", unless if you set an icon using the "icon" option
  buttons Array - Array of texts for buttons
  title String - Title of the message box, some platforms will not show it
  message String - Content of the message box
  detail String - Extra information of the message
  icon NativeImage
  cancelId Integer - The value will be returned when user cancels the dialog instead of clicking the buttons of the dialog. By default it is the index of the buttons that have "cancel" or "no" as label, or 0 if there is no such buttons. On OS X and Windows the index of "Cancel" button will always be used as cancelId, not matter whether it is already specified
  noLink Boolean - On Windows Electron would try to figure out which ones of the buttons are common buttons (like "Cancel" or "Yes"), and show the others as command links in the dialog, this can make the dialog appear in the style of modern Windows apps. If you don't like this behavior, you can specify noLink to true
  callback Function
  Shows a message box, it will block until the message box is closed. It returns the index of the clicked button.

  If a callback is passed, the API call will be asynchronous and the result will be passed via callback(response)
=end pod
  method show-message-box(:$browserWindow = Nil, :$options = {}) {
    my $handle = $browserWindow.defined ?? $browserWindow.handle !! -1;
    my $result = Atom::Electron::App.json-rpc.Dialog-show-message-box(
      handle   => $handle,
      options  => $options
    );
    return $result<selected>;
  }

=begin pod
  Runs a modal dialog that shows an error message.
  This API can be called safely before the ready event of app module emits,
  it is usually used to report errors in early stage of startup.
=end pod
  method show-error-box(Str $text, Str $content) {
    Atom::Electron::App.json-rpc.Dialog-show-error-box(
      :text($text), :content($content)
    );
    return;
  }

}