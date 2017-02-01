#!/bin/bash

set -e    # bail if fail

echo "Creating lab-manual.pdf."
echo "Assuming you're on a Mac with LibreOffice, pandoc, xelatex, wkhtmltopdf, and Automator."

echo "==========================================="
echo "Title page for hard-copy lab manual..."
xelatex -interaction=batchmode title-page.tex


echo "==========================================="
echo "hardware_setup.odg to pdf..."
/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to pdf hardware_setup.odg

echo "==========================================="
echo "README.md to .tex..."
pandoc --standalone --table-of-contents --variable=geometry:margin=1in --from=markdown --to=latex --output=README.tex README.md

echo "==========================================="
echo "README.tex to .pdf..."
# Note: Could use pdflatex, but I get error:
# $ "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o lab-manual.pdf README.pdf 
# Feb  1 06:01:02 Computron.local python[1624] <Error>: WARNING: Type1 font data isn't in the correct format required by the Adobe Type 1 Font Format specification.

xelatex -interaction=batchmode README.tex
xelatex -interaction=batchmode README.tex # twice for TOC

echo "==========================================="
echo "Matlab-published m-file html to pdf..."
wkhtmltopdf do_correlation_method/do_correlation_method.html do_correlation_method.pdf


echo "==========================================="
# (Linux use pdftk)
if [ -f "README.pdf" ] && [ -f "hardware_setup.pdf" ] && [ -f "do_correlation_method.pdf" ]; then
    echo "Concatenating pdf..."
    "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o lab-manual.pdf title-page.pdf README.pdf hardware_setup.pdf do_correlation_method.pdf
else
    echo "Something went wrong, missing one of: README.pdf hardware_setup.pdf do_correlation_method.pdf"
    exit
fi    

echo "==========================================="
echo "Clean up..."
rm *.aux *.log *.out *.toc
rm README.tex README.pdf do_correlation_method.pdf

open lab-manual.pdf