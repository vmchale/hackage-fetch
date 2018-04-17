.PHONY: fetch clean
.DEFAULT_GOAL := fetch

names:
	wget https://hackage.haskell.org/packages/names

all.txt: names
	rg '<a href="/package/.*?">.*?</a>' names -o | rg '>.*?<' -o > all.txt

clean:
	rm -rf hackage all.txt names

fetch: all.txt
	rm -rf hackage
	python3 script.py
