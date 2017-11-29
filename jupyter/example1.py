
print('Fetching lexc file...')
import urllib.request
data = urllib.request.urlopen('http://hfst.github.io/downloads/finntreebank.lexc')
s = data.read().decode('utf-8')
data.close()

# todo: implement hfst.compile_lexc(lexc_string)
f = open('finntreebank.lexc', 'w')
f.write(s)
f.close()

import hfst
print('Compiling the file...')
tr = hfst.compile_lexc_file('finntreebank.lexc')
assert(tr != None)
print('Inverting the transducer...')
tr.invert()
tr.minimize()

print('Testing the result:')
print('')
for word in ('testi','xtesti','alusta'):
    print(word + ':')
    print(tr.lookup(word, output='text'))

# todo: empty result should contain a newline?
# todo: the indentation of weights when there are several results
