#!/usr/bin/env perl6

sub pod(Str $text) {
  "\n=begin pod\n$text=end pod\n"
}

my constant $POD = "\n=begin pod\n=end pod\n";
my Str $pod_buffer = '';
my $buffer = '';
for "tools/tray.md".IO.lines -> $line {
  if $line ~~ / ^ '###' (.+) $ / {
    my $header = ~$/[0];
    if $header ~~ / ^ " Event: '" (.+) "'" $ / {
      # on-event method
      my $event_name = ~$/[0];
      if $buffer ne '' {
        say pod($pod_buffer) ~ $buffer;
      }
      $buffer = "method on-$event_name\(\$listener) \{\n}";
    } else {
      # method
      my Str $method = ~$header;
      if $buffer ne '' {
        say pod($pod_buffer) ~ $buffer;
      }
      $buffer = "method $method \{\n}";
    }

    $pod_buffer = '';

  } else {
    $pod_buffer ~= $line ~ "\n";
  }
}

