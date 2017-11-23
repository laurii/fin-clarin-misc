#!/usr/bin/perl

# Postprocess result from fsm2vrt.py and postprocess-ha-whitespace-and-punctuation.pl to handle lemmas.
# Read from standard input and write to standard output.

use strict;
use warnings;
use open qw(:std :utf8);

foreach my $line ( <STDIN> ) {

    if ( $line =~ /\tpropn/ )
    {
	$line =~ s/^([^\t]+)(\t[^\t]+\t[^\t]+\tpropn)/$1\t$1$2/g;
    }
    elsif ( $line =~ /\t\*\*\*/ )
    {
	$line =~ s/^([^\t]+)(\t[^\t]+\t[^\t]+\t\*\*\*)/$1\t$1$2/g;
    }
    else
    {
	$line =~ s/^([^\t]+)(\t[^\t]+\t[^\t]+\t[^\t])/$1\t\l$1$2/g;
    }

    print $line

}
