typst compile --root . main.typ
typst compile --root . main.typ --input handout=true handout.pdf
# cargo install --git https://github.com/andreasKroepelin/polylux/ --branch release
polylux2pdfpc --root . main.typ