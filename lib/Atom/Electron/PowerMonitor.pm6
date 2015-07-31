=begin pod
  This is the power monitor API wrapper which is described in
  https://github.com/atom/electron/blob/master/docs/api/power-monitor.md.md

  TODO implement Atom::Electron::PowerMonitor
=end pod
class Atom::Electron::PowerMonitor {

    use Atom::Electron::App;

=begin pod
  Register an event listener
TODO implement
=end pod
  method on($event_name, $listener) {
    !!!
    return;
  }

=begin pod
  Register an event to be notifed when the system is suspending.
=end pod
  method on_suspend($listener) {
    self.on('suspend', $listener);
    return;
  }

=begin pod
  Register an event to be notifed when the system is resuming.
=end pod
  method on_resume($listener) {
    self.on('resume', $listener);
    return;
  }

=begin pod
  Register an event to be notifed when the system changes to AC power.
=end pod
  method on_ac($listener) {
    self.on('on-ac', $listener);
    return;
  }

=begin pod
  Register an event to be notifed when the system changes to battery power.
=end pod
  method on_battery($listener) {
    self.on('on-battery', $listener);
    return;
  }

}
