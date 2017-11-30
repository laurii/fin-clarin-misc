import hfst
istr = hfst.HfstInputStream()
ostr = hfst.HfstOutputStream()

for tr in istr:
    tr.invert()
    tr.minimize()
    ostr.write(tr)
    ostr.flush()

istr.close()
ostr.close()
