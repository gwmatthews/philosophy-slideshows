RMD_FILES=$(filter-out $(wildcard *-src.Rmd), $(wildcard *.Rmd))

TEX_FILES=$(wildcard *.tex)

HTML_FILES=$(patsubst %.Rmd, %.html, $(RMD_FILES))

PDF_FILES=$(patsubst %.html, %.pdf, $(HTML_FILES))

PRINT_FILES=$(patsubst %-print.tex, %-print.pdf, $(TEX_FILES))

.PHONY : all
all : $(HTML_FILES) $(PDF_FILES) $(PRINT_FILES) cleanup

.PHONY : cleanup
cleanup :
	rm -f ./pdf/*-Print.pdf
	rm -f ./*-Print.html
	rm -f ./pdf/*.aux
	rm -f ./pdf/*.log
	
	

# Create print version of slideshow

%.pdf : %.tex
	pdflatex -output-directory pdf $< 

# Read print verion of html and convert to pdf

%.pdf : %.html
	R -e 'pagedown::chrome_print("$<", "pdf/$@")'

# process RmD to html

%.html : %.Rmd
	R -e 'rmarkdown::render("$<", output_file = "$@")'
	
clean :
	rm -f ./*.html
	rm -f ./pdf/*.pdf
