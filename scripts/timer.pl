#!/bin/env perl

use strict;
use warnings;
use feature ':all';

$| = 1;  # autoflush stdout

my ($delay) = shift @ARGV;
$delay = '10m' unless ($delay);
my ($interval, $unit) = ($delay =~ /(\d+\.?\d*)([msh]{0,1})/);
$unit = 's' if ($unit eq '');
die usage() unless($interval && $unit);
my $mul = ($unit eq 's') ? 1
        : ($unit eq 'm') ? 60
        : ($unit eq 'h') ? 60 * 60
        : undef;

my $waittime = $interval * $mul;

my %unitnames = (s => 'seconds', m => 'minutes', h => 'hours' );

my $dialog = qq(zenity --progress --text="Waiting" --auto-close --percentage=100);
open(my $progress, '|-', $dialog) or die $!;
$progress->autoflush();
my $tick = ($waittime < 60) ? 1 : 5 ;
for my $i (1..$waittime) {
    if ($i == 1 || $i % $tick == 0) {
        $progress->print("# Remaining: " . sprintf("%d", ($waittime-$i)/$mul) . ":" . sprintf("%d", ($waittime-$i)%60) . " " . $unitnames{$unit} . "\n");
        $progress->print(100 - (100 * $i/$waittime), "\n");
    }
    sleep 1;
}

sub usage {
    return <<~"EOT";
    Invalid delay $delay
    Usage: $0 interval
    where interval = X[s] or Xm or Xh
          Xm = X is minutes
          Xh = X is hours
          Xs (or no modifier) = X is seconds
    EOT
}

