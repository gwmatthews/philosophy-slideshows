RMD_FILES:=$(filter-out $(wildcard *-src.Rmd), $(wildcard *.Rmd))

TEX_FILES:=$(wildcard *.tex)

HTML_FILES:=$(patsubst %.Rmd, %.html, $(RMD_FILES))

PDF_FILES:=$(patsubst %.html, %.pdf, $(HTML_FILES))

PRINT_FILES:=$(patsubst %-print.tex, %-print.pdf, $(TEX_FILES))

.PHONY : all
all : ${HTML_FILES} ${PDF_FILES} ${PRINT_FILES} cleanup

# render RmD to html

%.html : %.Rmd
	R -e 'rmarkdown::render("$<", output_file = "$*.html")'

# Convert html to pdf

%.pdf : %.html
	R -e 'pagedown::chrome_print("$<", "pdf/$*.pdf")'

# Create print version of slideshow

%-print.pdf : %-print.tex 
	pdflatex -output-directory pdf $< 

# Remove temporary files used in building pdf 

.PHONY : cleanup
cleanup :
	rm -f ./pdf/*-Print.pdf
	rm -f ./*-Print.html
	rm -f ./pdf/*.aux
	rm -f ./pdf/*.log
	
clean :
	rm -f ./*.html
	rm -f ./pdf/*.pdf

