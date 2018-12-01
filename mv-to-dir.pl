#!/bin/perl

eval 'exec /usr/bin/perl  -S $0 ${1+"$@"}'
    if 0; # not running under some shell

=begin COPYRIGHT

   mv-to-dir - move file into directory of the same name
	Copyright (C) 2015 Benjamin Abendroth
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.

=end COPYRIGHT

=cut

use 5.010001;
use feature 'say';
use strict;
use warnings;

die "Missing arguments\n" unless @ARGV;

use File::Copy;# qw(move);
use File::Path;# qw(make_path);
use Getopt::Long qw(:config gnu_getopt auto_version);

$main::VERSION = 0.1;

GetOptions(
   'help|h' => sub {
      require Pod::Usage;
      Pod::Usage::pod2usage(-exitstatus => 0, -verbose => 1);
   }
) or exit 1;

die "Missing arguments\n" unless @ARGV;

my $exit = 0;

for my $file (@ARGV)
{
   eval {
      mv_to_dir($file); 1
   }
   or do {
      $exit = 1;
      warn "$file: $@";
   };
}

exit $exit;

sub mv_to_dir 
{
   my ($file) = @_;

   move($file, "$file.mv-to-dir") or die "$!\n";

   make_path($file) or do {
      my $err_msg = $!;
      move("$file.mv-to-dir", $file) or die "$!\n";
      die "$err_msg\n";
   };

   move("$file.mv-to-dir", "$file/$file") or die "$!\n";
}


__END__

=pod

=head1 NAME

mv-to-dir - move file into directory of the same name

=head1 SYNOPSIS

=over 8

mv-to-dir [OPTIONS] FILES

=back

=head1 OPTIONS

=head2 Basic Startup Options

=over

=item B<--help>

Display this help text and exit.

=item B<--version>

Display the script version and exit.

=back

=head1 AUTHOR

Written by Benjamin Abendroth.

=cut

