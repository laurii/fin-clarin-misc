import hfst
from sys import argv

istr = hfst.HfstInputStream()
ostr = hfst.HfstOutputStream()

for tr in istr:
    tr.invert()
    tr.minimize()
    ostr.write(tr)
    ostr.flush()

istr.close()
ostr.close()
