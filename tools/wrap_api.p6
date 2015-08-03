#!/usr/bin/env perl6

sub pod(Str $text) {
  "\n=begin pod\n$text=end pod\n"
}

sub perl6ish_method_name(Str $method is copy) {
  $method = $method.subst(/ ^ \s* \w+ '.' /, "");
  $method = $method.subst(/ (<[A..Z]>) /, {"-" ~ $0.lc}, :g);
  $method = $method.subst(/ ^ '-' / , "" );
  return $method;
}

my $file-name = "tools/tray.md";
my constant $POD = "\n=begin pod\n=end pod\n";
my Str $pod_buffer = '';
my $buffer = '';
my @methods;
my @events;
for $file-name.IO.lines -> $line {
  if $line ~~ / ^ '###' (.+) $ / {
    my $header = ~$/[0];
    if $header ~~ / ^ " Event: '" (.+) "'" $ / {
      # on-event method
      my $event = ~$/[0];
      if $buffer ne '' {
        say pod($pod_buffer) ~ $buffer;
      }
      $buffer = "method on-$event\(\$listener) \{\n  self.on('$event', \$listener);\n}";
      @events.push($event.subst(q{'}, q{}));
    } else {
      # method
      my Str $method = ~$header;
      if $buffer ne '' {
        say pod($pod_buffer) ~ $buffer;
      }
      $buffer = "method $method \{\n!!!\n}";
      $method = perl6ish_method_name($method);
      @methods.push($method);
    }

    $pod_buffer = '';

  } else {
    $pod_buffer ~= $line ~ "\n";
  }
}

say "\n=begin pod";
say "  " ~ @events.map({ "'$_'" }).join(",");
say "  " ~ @methods.map({ "'$_'" }).join(",");
say "\n=end pod";

