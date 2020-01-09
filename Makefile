RMD_FILES = $(filter-out $(wildcard *-src.Rmd), $(wildcard *.Rmd))

HTML_FILES=$(patsubst %.Rmd, %.html, $(RMD_FILES))

PDF_FILES=$(patsubst %.html, %.pdf, $(HTML_FILES))

.PHONY : all
all : $(HTML_FILES) $(PDF_FILES) cleanup

.PHONY : cleanup
cleanup :
	rm -f ./pdf/*-Print.pdf
	

# Create print version of slideshow
%-print.pdf : %-print.tex
	pdflatex "$<"

# Read print verion of html and convert to pdf

%.pdf : %.html
	R -e 'pagedown::chrome_print("$<", "pdf/$@")'

# process RmD to html

%.html : %.Rmd
	R -e 'rmarkdown::render("$<", output_file = "$@")'
	
clean :
	rm -f ./*.html
	rm -f ./pdf/*.pdf
