#!/bin/sh

if [ "$1" = "--help" -o "$1" = "-h" ]; then
    echo ""
    echo "Usage: statute-generate-all-vrt-files.sh [--fin|--swe] --from-year YEAR --to-year YEAR --only-file FILE"
    echo ""
    exit 0
fi

url_lang=""
dir_lang=""
from_year=""
to_year=""
only_file=""

for arg in "$@"
do
    if [ "$arg" = "--fin" ]; then
	url_lang="fin"
	dir_lang="fi"
    elif [ "$arg" = "--swe" ]; then
	url_lang="swe"
	dir_lang="sv"
    elif [ "$arg" = "--from-year" ]; then
	from_year="next..."
    elif [ "$arg" = "--to-year" ]; then
	to_year="next..."
    elif [ "$arg" = "--only-file" ]; then
	only_file="next..."
    elif [ "$from_year" = "next..." ]; then
	from_year=$arg
    elif [ "$to_year" = "next..." ]; then
	to_year=$arg
    elif [ "$only_file" = "next..." ]; then
	only_file=$arg
    fi
done

if [ "$url_lang" = "" ]; then
    echo "Error: language must be defined with --fin or --swe."
    exit 1
fi


for dir in ${dir_lang}/*
do

    year=`echo $dir | perl -pe 's/(?:fi)|(?:swe)//; s/\///g'`
    if [ "$from_year" != "" ]; then
	if [ "$year" -lt "$from_year" ]; then
	    continue
	fi
    elif [ "$to_year" != "" ]; then
	if [ "$year" -gt "$to_year" ]; then
	    continue
	fi
    fi

    for f in $dir/*.xml
    do

	if [ "$only_file" != "" ]; then
	    if [ "$only_file" != "$f" ]; then
		continue
	    fi
	fi	
    
	prefile=`echo $f | perl -pe 's/\.xml/\.pre/'`
	extfile=`echo $f | perl -pe 's/\.xml/\.ext/'`
	punctfile=`echo $f | perl -pe 's/\.xml/\.punct/'`
	sentfile=`echo $f | perl -pe 's/\.xml/\.sent/'`
	vrtfile=`echo $f | perl -pe 's/\.xml/\.vrt/'`
	
	echo "processing xml file "$f"..."
	
	if ! (./statute-preprocess.pl < $f > $prefile); then
	    echo "Error: in statute-preprocess.pl, exiting..."
	    exit 1
	fi
	if ! (./statute-extract-text.pl < $prefile > $extfile); then
	    echo "Error: in statute-extract-text.pl, exiting..."
	    exit 1
	fi
	if ! (./statute-handle-punctuation.pl < $extfile > $punctfile); then
	    echo "Error: in statute-handle-punctuation.pl, exiting..."
	    exit 1
	fi
	if ! (./statute-add-sentence-tags.pl < $punctfile > $sentfile); then
	    echo "Error: in statute-add-sentence-tags.pl, exiting..."
	    exit 1
	fi
	
	# extract year and statute number from the name of vrt file
	url_year=`echo $vrtfile | perl -pe 's/.*asd([0-9][0-9][0-9][0-9]).*/$1/g;'`
	url_number=`echo $vrtfile | perl -pe 's/\.vrt//g; s/(fi|sv)\/[0-9][0-9][0-9][0-9]\///g; s/(s|t)$//g; s/asd[0-9][0-9][0-9][0-9]//g; s/^0+//g;'`
	
	url="http://data.finlex.fi/eli/sd/"$url_year"/"$url_number"/alkup/"$url_lang".html"
	
	# extract date of document from xml file
	datefrom=`grep -m 1 'met1:laadintaPvm=' $f | perl -pe 's/^.*met1\:laadintaPvm="([0-9]{4}\-[0-9]{2}\-[0-9]{2})".*$/$1/g; s/\-//g;'`
	length=`printf "%s" "$datefrom" | wc -c`
	if [ "$length" = "0" ]; then
	    datefrom=$url_year"0101"
	    dateto=$url_year"1231"
	    echo "could not find date in file '"$1"', setting it to "$datefrom" - "$dateto" for output file '"$2"'..."
	elif [ "$datefrom" = "21000101" ]; then
	    datefrom=$url_year"0101"
	    dateto=$url_year"1231"
	    echo "date '2100-01-01' given in file '"$1"', setting it to "$datefrom" - "$dateto" for output file '"$2"'..."
	elif [ "$length" -gt 8 -o "$length" -lt 8 ]; then
	    echo "invalid date in file '"$1"' (output file '"$2"'), exiting..."
	    exit 1
	else
	    dateto=$datefrom
	fi
		
	# add text tags around the output
	echo '<text filename="'$vrtfile'" datefrom="'$datefrom'" dateto="'$dateto'" timefrom="000000" timeto="235959" url="'$url'">' > $vrtfile
	cat $sentfile >> $vrtfile
	echo "</text>" >> $vrtfile

    done 

done

