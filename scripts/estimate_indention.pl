#!/usr/bin/env perl

use 5.038;
use strict;
use warnings;
use File::Basename qw(fileparse);
use File::Spec;

my ($path) = shift;

if (!$path || !-d $path) {
    say "Usage: $0 <dir>"
}
my %indent_by_type = ();
dir_walk($path, sub ($file) {
      my $res = guess_indentation($file);
      my $type = $res->{type};
      my $freq = $res->{frequency};
      if (!exists($indent_by_type{$type})) {
          $indent_by_type{$type} = $freq;
      }
      else {
        for my $k (keys %$freq) {
            $indent_by_type{$type}{$k} ||= 0;
            $indent_by_type{$type}{$k} += $freq->{$k};
        }
      }
  });

for my $type (sort keys %indent_by_type) {
  my $freq = $indent_by_type{$type};
  my @stops = grep { $_ > 0 } sort { $a <=> $b } (keys %$freq);
  my $stop = shift @stops;
  if ($stop) {
    say "inconsistent stops for $type" if (scalar @stops > grep { $_ % $stop == 0 } @stops );
  }
  say "$type - $stop";
}

sub dir_walk($path, $action) {
 opendir(my $dh, $path) || die "Error opening directory $path - $!";
 while (my $ent = readdir($dh)) {
   next if ($ent =~ /^\.+/);
   say $ent;
   my $ent_path = File::Spec->catfile($path, $ent);
   if (-d $ent_path) {
     say "$ent is a directory, descending...";
     dir_walk($ent_path, $action);
   }
   else {
      $action->($ent_path);
   }
 }
}

sub guess_indentation($file) {
  open(my $fh, '<', $file) || die "Error opening $file - $!";
  my ($a, $b, $suffix) = fileparse($file, qr/.[^.]+/);
  $suffix =~ s/^.//;
  my %freq;
  my $prev_indent = 0;
  while (my $line = <$fh>) {
    my $indent = undef;
    if ($line =~ /^( *)\S+/) {
      $indent = $1;
      my $count = $indent =~ tr/ / /;
      my $diff = abs($count-$prev_indent);
      next if ($diff % 2 != 0);  # we only expect an even number as indent size
      $freq{$diff} = 1 + ((exists($freq{$diff})) ? $freq{$diff} : 0);
    }
    else {
      ;
      # print "No indent: |$line";
        # empty or with tabs
    }
  }
  return { type => $suffix, frequency => \%freq };
}


