Raja-Karjalan korpus (13.1.2017)

Tämä kansio sisältää Raja-Karjalan korpuksen. Korpus käsittää haastatteluja kuudelta eri pitäjältä, jotka kaikki ovat omissa erillissä alikansioissaan. Jokainen näistä pitäjäkohtaisista alikansioista sisältää kolme erillistä kansiota; *_textgrid (pitäjäkohtaiset lausumatason TextGrid-tiedostot (UTF-16)), *_txt (pitäjäkohtaiset litteraatio–txt-tiedostot (UTF-8)) sekä *_wav (pitäjäkohtaiset äänitiedostot).

Editoitu versio (28.11.2017)

# Laske näytteenottotaajuutta:
for f in */*/*.wav; do ffmpeg -i $f -ar 22050 output.wav && mv --force output.wav $f; done

# "Using AVStream.codec.time_base as a timebase hint to the muxer is deprecated. Set AVStream.time_base instead."?

# .wav -> .m4a
for f in */*/*.wav; do ffmpeg -i $f -c:a libfdk_aac -vbr 1 `echo $f | perl -pe 's/\.wav/\.m4a/;'`; done

# [libfdk_aac @ 0x1f97380] Note, the VBR setting is unsupported and only works with some parameter combinations
# [ipod @ 0x1f96420] Using AVStream.codec.time_base as a timebase hint to the muxer is deprecated. Set AVStream.time_base instead.

# Get rid of lowest tier named "original" from TextGrid files: not needed

# Convert TextGrid files from UTF-16 to UTF-8
for f in */*/*.TextGrid; do iconv -f UTF-16 -t UTF-8 $f -o tmp && mv --force tmp $f; done
