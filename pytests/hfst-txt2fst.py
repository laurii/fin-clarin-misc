import hfst
from sys import argv
epsilon=None
inputfile=None
impl=hfst.ImplementationType.TROPICAL_OPENFST_TYPE
for i in range(1, len(argv)):
    arg = argv[i]
    if arg == '-f':
        val = argv[i+1]
        if val == 'sfst':
            impl = hfst.ImplementationType.SFST_TYPE
        elif val == 'openfst-tropical':
            impl = hfst.ImplementationType.TROPICAL_OPENFST_TYPE
        elif val == 'foma':
            impl = hfst.ImplementationType.FOMA_TYPE
        else:
            raise RuntimeError('type not recognized: ' + val)
    elif arg == '-e':
        epsilon = argv[i+1]
    elif arg == '-i':
        inputfile = argv[i+1]
    else:
        raise RuntimeError('argument not recognized: ' + arg)
