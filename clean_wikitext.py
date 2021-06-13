#to clean blank spaces

import sys
with open("wikitext.txt") as f:
    for line in f:
        if not line.isspace():
            sys.stdout.write(line)
