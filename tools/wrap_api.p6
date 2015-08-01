#!/usr/bin/env perl6

#say $*SPEC;
my $text = "tools/tray.md".IO.slurp;

#say $text ~~ / '###' /:g;

for $text.lines -> $line {
  if $line ~~ / ^ '###' (.+) $ / {
    say $line;
    my $signature = ~$/[0];
    say $signature;
    if $signature ~~ / ^ 'Event: ' (.+) $ / {
      # Event
      my $event_name = ~$/[0];
      say $event_name;
      say "method on-$event_name\(\$listener) { }";
    } else {
      # method
      my Str $method = $/[0];
      say $method;
      say "method $method { }";
    }
  }
  
}

