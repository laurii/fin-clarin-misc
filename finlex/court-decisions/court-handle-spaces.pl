#!/usr/bin/perl

use strict;
use warnings;
use open qw(:std :utf8);

foreach my $line ( <STDIN> ) {

    $line =~ s/\x{A0}/ /g;
    $line =~ s/\x{1680}/ /g;
    $line =~ s/\x{2000}/ /g;
    $line =~ s/\x{2001}/ /g;
    $line =~ s/\x{2002}/ /g;
    $line =~ s/\x{2003}/ /g;
    $line =~ s/\x{2004}/ /g;
    $line =~ s/\x{2005}/ /g;
    $line =~ s/\x{2006}/ /g;
    $line =~ s/\x{2007}/ /g;
    $line =~ s/\x{2008}/ /g;
    $line =~ s/\x{2009}/ /g;
    $line =~ s/\x{200A}/ /g;
    $line =~ s/\x{2028}/ /g;
    $line =~ s/\x{2029}/ /g;
    $line =~ s/\x{202F}/ /g;
    $line =~ s/\x{205F}/ /g;
    $line =~ s/\x{3000}/ /g;
    # soft hyphen
    $line =~ s/\x{AD}//g;
    print $line;
}
