#!/bin/bash

set -x    # bail if fail

# hardware_setup.odg to pdf
/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to pdf hardware_setup.odg

# README.md to .tex
pandoc --standalone --table-of-contents --variable=geometry:margin=1in --from=markdown --to=latex --output=README.tex README.md

# .tex to .pdf
pdflatex README.tex
pdflatex README.tex # twice for TOC

rm *.aux *.log *.out *.toc

# concat pdfs.
# (Linux use pdftk)
"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o lab-manual.pdf README.pdf hardware_setup.pdf

rm README.tex README.pdf
