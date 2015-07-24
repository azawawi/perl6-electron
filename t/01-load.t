use v6;

BEGIN { @*INC.push('lib') };

use Test;

plan 2;

use Atom::Electron;
ok 1, "'use Atom::Electron' worked!";
ok Atom::Electron.new, "Atom::Electron.new worked";
