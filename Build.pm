use v6;

unit class Build;

method build($workdir) {
  # The electron process is not found, help the module user a bit :)
  use File::Which;
  unless which('electron').defined {
    say q{
electron is not found in your PATH. Please follow the instructions in
https://github.com/azawawi/perl6-electron/blob/master/README.md

Thanks for using this module :)
    };
  }
}

# only needed for older versions of panda
method isa($what) {
    return True if $what.^name eq 'Panda::Builder';
    callsame;
}
