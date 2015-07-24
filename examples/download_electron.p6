#!/usr/bin/env perl6
use v6;

use LWP::Simple;

my $release = 'electron-v0.30.1';
my %releases = (
  'MSWin32_32' =>  'win32-ia32.zip',
  'MSWin32_64' =>  'win32-x64.zip',
  #'-darwin-x64.zip',
  #'electron-v0.30.1-linux-arm.zip',
  #'electron-v0.30.1-linux-ia32.zip',
  #'electron-v0.30.1-linux-x64.zip',
);

my $distribution = "$release--linux-x64.zip'";
my $url = "https://github.com/atom/electron/releases/download/v0.30.1";
my $file = $distribution;
my $lwp = LWP::Simple.new;
$lwp.getstore($url, $file);

say "Hello world";
