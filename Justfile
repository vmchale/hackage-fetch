index:
    rm -rf names all.txt
    duma https://hackage.haskell.org/packages/names
    rg '<a href="/package/.*?">.*?</a>' names -o | rg '>.*?<' -o > all.txt

clean:
    rm -rf hackage all.txt rm -rf names

fetch: index
    rm -rf hackage/
    python3 script.py
    rm -f all.txt names
