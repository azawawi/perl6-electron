=begin pod
  This is the process API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/process.md
=end pod
unit class Electron::Process;

use Electron::App;

=begin pod
Returns the process.version strings as a hash
=end pod
method versions {
  return Electron::App.json-rpc.Process-versions<result>;
}

=begin pod
Returns the Electron version string
=end pod
method electron-version {
  return self.versions<electron>;
}

=begin pod
Returns the chrome/chromium version string
=end pod
method chrome-version {
  return self.versions<chrome>;
}

