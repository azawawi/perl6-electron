use v6;

use Panda::Builder;

class Build is Panda::Builder {
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
}
