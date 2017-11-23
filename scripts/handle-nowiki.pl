#!/usr/bin/perl

use strict;
use warnings;
use open qw(:std :utf8);

if( $ARGV[0] eq '-h' || $ARGV[0] eq '-help' || $ARGV[0] eq '--help' )
{
    help();
    exit;
}

sub help 
{
    print "\n";
    print "Read from standard input and write to standard output.\n";
    print "Convert <verbatim> ... <\/verbatim> sections to\n";
    print "<nowiki> ... <\/nowiki> sections, adding indentations and\n";
    print "empty lines as required by mediawiki format.\n";
    print "\n";
}

my $nowiki = "false";

foreach my $line ( <STDIN> )
{
    if ( $nowiki eq "true" )
    {
	unless ( $line =~ /^<\/nowiki>$/)
	{
	    print "    $line"; # indentation needed inside <nowiki> ... <\/nowiki>
	}
	else
	{
	    print "    \n$line";
	    $nowiki = "false";
	}
    }	
    else
    {
	if ( $line =~ /^<nowiki>$/)
	{
	    $nowiki = "true";
	    print "$line    \n";
	}
	else
	{
	    print "$line";
	}
    }
}
