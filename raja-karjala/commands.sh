
# Decrease sampling rate
for f in */*/*.wav; do ffmpeg -i $f -ar 22050 output.wav && mv --force output.wav $f; done

# "Using AVStream.codec.time_base as a timebase hint to the muxer is deprecated. Set AVStream.time_base instead."

# From wav to m4a
for f in */*/*.wav; do ffmpeg -i $f -c:a libfdk_aac -vbr 1 `echo $f | perl -pe 's/\.wav/\.m4a/;'`; done

# [libfdk_aac @ 0x1f97380] Note, the VBR setting is unsupported and only works with some parameter combinations
# [ipod @ 0x1f96420] Using AVStream.codec.time_base as a timebase hint to the muxer is deprecated. Set AVStream.time_base instead.
