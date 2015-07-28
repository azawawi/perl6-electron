use v6;

BEGIN { @*INC.push('lib') };

use Test;

plan 0;
exit 1;

use Atom::Electron::Clipboard;
ok 1, "'use Atom::Electron::Clipboard' worked!";

my $app = Atom::Electron::App.instance;
END: {
  $app.destroy;
}

# Write to clipboard
my $t1 = 'Hello world';
Atom::Electron::Clipboard.write_text($t1);

# Read and match if it is the same
my $t2 = Atom::Electron::Clipboard.read_text;
ok $t1 eq $t2, "write_text/read_text matched";

# Clear clipboard and check if its empty
Atom::Electron::Clipboard.clear;
my $empty = Atom::Electron::Clipboard.read_text;
ok $empty eq '', "clear clipboard worked";
