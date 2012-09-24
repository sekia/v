#!/usr/bin/env perl

use 5.012;
use strict;
use warnings;

sub all(&@) {
  my $pred = shift;
  for (@_) { return unless $pred->($_); }
  return 1;
}

sub part(&@) {
  my $index = shift;
  my @partitioned;
  push @{ $partitioned[ $index->($_) ] //= [] }, $_ for @_;
  return @partitioned;
}

my ($opts, $files) = part { /^-/ ? 0 : 1 } @ARGV;
$opts //= [];
$files //= [];
push @$files, '.' unless @$files;
for my $file (@$files) {
  warn "No such file or directory: $file" unless -e $file;
}

my $dir_only = all { -d $_ } @$files;
my $cmd = $dir_only ? 'ls' : 'less';
exec $cmd, @$opts, @$files;
