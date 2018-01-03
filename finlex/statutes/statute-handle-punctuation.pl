#!/usr/bin/perl

use strict;
use warnings;
use open qw(:std :utf8);

foreach my $line ( <STDIN> ) {

    unless ( $line =~ /^<[^>]/)
    {
	# special symbol <> used for end of sentence in titles etc.
	$line =~ s/<>/ <> /g;

	# special symbol <-> checked here
	$line =~ s/([a|e|i|o|u|y])<\->\1/$1\-$1/g;
	$line =~ s/<\->(\p{Lower})/$1/g;
	$line =~ s/<\->/\-/g;
	
	# literal '\n'
	$line =~ s/\\n/ /g;

	# separate parentheses () and []
	$line =~ s/([^ ])\(/$1 \(/g;
	$line =~ s/\)([^ ])/\) $1/g;
	$line =~ s/([^ ])\[/$1 \[/g;
	$line =~ s/\]([^ ])/\] $1/g;
	
	# , ; and : at the end of a word or line is separated
	$line =~ s/(,|\;|:) / $1 /g;
	$line =~ s/(,|\;|:)$/ $1/;

	# escape some common abbreviations that end in dot and do not (ever?) end a sentence: . -> <.>
	$line =~ s/ esim\./ esim<\.>/g;
	$line =~ s/ v\./ v<\.>/g;
	$line =~ s/ t\. ?ex\./ t<\.>ex<\.>/g; # almost always written together: "t.ex."
	$line =~ s/Vt\./Vt<\.>/g;
	$line =~ s/Tf\./Tf<\.>/g;

	# . at the end of a word (followed by space and capital letter or parenthesis) or line is separated
	$line =~ s/(.)\. (\p{Upper}|\(|\[)/$1 \. $2/g;
	$line =~ s/\. *$/ \./;

	# unescape escaped dots
	$line =~ s/<\.>/\./g;

	# separate content inside parentheses from parentheses
	$line =~ s/\(([^\)]+)\)/\( $1 \)/g;
	$line =~ s/\[([^\]]+)\]/\[ $1 \]/g;

	# separate double quotes
	$line =~ s/"/ " /g;

	# previous replacements might have generated too many spaces
	$line =~ s/ +/ /g;
	
	# each word/punctuation on its own line
	$line =~ s/^ +//g;
	$line =~ s/ +$//g;
	$line =~ s/ /\n/g;
	
	# ? and ! not used in statutes? TODO: check
    }
    
    print $line;

}
