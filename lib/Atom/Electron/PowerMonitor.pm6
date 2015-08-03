=begin pod
  This is the power monitor API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/power-monitor.md

  This is used to monitor the power state change. You should only use it after
  the ready event of an application is fired.

    use Atom::Electron::PowerMonitor;
    Atom::Electron::PowerMonitor.on-suspend(sub {
        say 'The system is going to sleep';
    });

=end pod
class Atom::Electron::PowerMonitor {

    use Atom::Electron::App;

=begin pod
  Register an event listener
TODO implement
=end pod
  method on($name, $listener) {
    !!!
    return;
  }

=begin pod
  Register an event to be notifed when the system is suspending.
=end pod
  method on-suspend($listener) {
    self.on('suspend', $listener);
    return;
  }

=begin pod
  Register an event to be notifed when the system is resuming.
=end pod
  method on-resume($listener) {
    self.on('resume', $listener);
    return;
  }

=begin pod
  Register an event to be notifed when the system changes to AC power.
=end pod
  method on-ac($listener) {
    self.on('on-ac', $listener);
    return;
  }

=begin pod
  Register an event to be notifed when the system changes to battery power.
=end pod
  method on-battery($listener) {
    self.on('on-battery', $listener);
    return;
  }

}
