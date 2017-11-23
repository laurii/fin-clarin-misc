#!/bin/sh

if [ "$1" = "--help" -o "$1" = "-h" ]; then
    echo ""
    echo "Usage: court-process-xml-to-vrt.sh XMLFILE VRTFILE [--datefrom DATE] [--dateto DATE] [--kko|--kho] [--fin|--swe]"
    echo ""
    exit 0
fi

datefrom=""
dateto=""
url_lang=""
court=""

for arg in "$@"
do
    if [ "$datefrom" = "next..." ]; then
	datefrom=$arg
    elif [ "$dateto" = "next..." ]; then
	dateto=$arg
    elif [ "$arg" = "--datefrom" ]; then
	datefrom="next..."
    elif [ "$arg" = "--dateto" ]; then
	dateto="next..."
    elif [ "$arg" = "--fin" ]; then
	url_lang="fin"
    elif [ "$arg" = "--swe" ]; then
	url_lang="swe"
    elif [ "$arg" = "--kko" ]; then
	court="kko"
    elif [ "$arg" = "--kho" ]; then
	court="kho"
    fi
done

if [ "$url_lang" = "" ]; then
    echo "Error: language must be defined with --fin or --swe."
    exit 1
fi

if [ "$court" = "" ]; then
    echo "Error: court must be defined with --kko or --kho."
    exit 1
fi


cp $1 tmp

#if [ "$url_lang" = "fin" ]; then
#    swedish=`egrep ' (att|om|var|är) ' tmp`
#    if ! [ "$swedish" = "" ]; then
#	echo "Warning: file '"$1"' seems to contain Swedish, although --fin was requested:"
#	echo $swedish
#    fi
#fi

if ! (cat tmp | ./court-extract-text.pl > TMP); then
    echo "Error: in court-extract-text.pl("$1", "$2"), exiting..."
    exit 1
fi
./court-handle-spaces.pl < TMP > tmp
./court-handle-punctuation.pl < tmp > TMP
if ! (./court-add-sentence-tags.pl < TMP > tmp); then
    echo "Error: in court-add-sentence-tags.pl("$1", "$2"), exiting..."
    exit 1
fi
mv tmp TMP



url_year=`echo $1 | perl -pe 's/.*'${court}'([0-9][0-9][0-9][0-9]).*/$1/g;'`
url_number=""

if [ "$court" = "kko" ]; then
    url_number=`echo $1 | perl -pe 's/\.xml//g; s/(fi|sv)\/[0-9][0-9][0-9][0-9]\///g; s/(s|t)$//g; s/'${court}'[0-9][0-9][0-9][0-9]//g; s/^0+//g;'`
    # For years until 1986, there is "II" in the urls for KKO decisions
    if [ "$url_year" -lt "1987" ]; then
	url_number="II"$url_number
    fi
elif [ "$court" = "kho" ]; then
    url_number=`grep -m 1 '<finlex:ecliIdentifier' $1 | perl -pe 's/.*<finlex\:ecliIdentifier>.*\:(T?[0-9]+)<\/finlex\:ecliIdentifier>.*/$1/g;'`
fi

url="http://data.finlex.fi/ecli/"$court"/"$url_year"/"$url_number"/"$url_lang".html"

if [ "$datefrom" = "" -a "$dateto" = "" ]; then
    datefrom=`grep -m 1 '<dcterms:issued' $1 | perl -pe 's/.*<dcterms\:issued( +pvm=\"[0-9]+\" *)?\>([^<]*)<.*/$2/g; s/\-//g;'`
    length=`printf "%s" "$datefrom" | wc -c`
    if [ "$length" = "0" ]; then
	datefrom=$url_year"0101"
	dateto=$url_year"1231"
	echo "could not find date in file '"$1"', setting it to "$datefrom" - "$dateto"..."
    elif [ "$length" -gt 8 -o "$length" -lt 8 ]; then
	echo "invalid date in file '"$1"', exiting..."
	exit 1
    else
	dateto=$datefrom
    fi
fi

echo '<text filename="'$2'" datefrom="'$datefrom'" dateto="'$dateto'" timefrom="000000" timeto="235959" url="'$url'">' > tmp
cat TMP >> tmp
echo "</text>" >> tmp
mv tmp $2
rm TMP

