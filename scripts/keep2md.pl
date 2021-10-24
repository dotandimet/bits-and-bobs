#!/usr/bin/env perl

use Mojo::Base -strict, -signatures;
use Mojo::JSON qw(decode_json);
use Mojo::File qw(path);
use Mojo::Date;
use Mojo::Util qw(encode);


my ($keep_dir, $out_dir) = @ARGV;

die "Usage: $0 keep_takeout_directory markdown_output_directory\n"
  unless ($keep_dir && -d $keep_dir && $out_dir && -d $out_dir);

my $f = path($keep_dir);
$f->list_tree->grep(sub {/\.json$/})->grep(sub { extract($_) })->each(sub { say $_ });


sub extract ($file) {
  my $j = decode_json($file->slurp);
  my ($label) = ($j->{labels}) ? $j->{labels}[0]{name} : undef;
  return unless ($label && $label =~ /(Agents|Academy)/);
  $label =~ s/The //;
  my ($title, $text, $timestamp) = ($j->{title}, ($j->{textContent} || ''), $j->{userEditedTimestampUsec});
  if ($j->{listContent}) {
	for my $item ($j->{listContent}->@*) {
		my $check = ($item->{'isChecked'}) ? '[x]' : '[ ]';
		$text .= "- $check " . $item->{'text'} . "\n";
	}
  }
  my @pics;
  if ($j->{attachments}) {
    @pics = map {

      # copy images:
      $file->dirname()->child($_)->copy_to($out_dir);
    } map { $_->{filePath} } $j->{attachments}->@*;
  }
  path($out_dir, $file->basename('.json') . '.md')->spurt(
	encode('UTF-8', join( "\n",
  '---',
  'created: ' . Mojo::Date->new($timestamp / 1000000),
  '---',
  "# $title",
  (map { "![[$_]]" } map { $_->basename } @pics),
  $text,
  "#$label"
  )) );
}

