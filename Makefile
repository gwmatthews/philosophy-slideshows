SRC:=$(filter $(wildcard *-src.Rmd), $(wildcard *.Rmd))

SLIDES:=$(filter $(wildcard *-slides.Rmd), $(wildcard *.Rmd))
SLIDES_HTML:=$(patsubst %.Rmd, %.html, $(SLIDES))
SLIDES_PDF:=$(patsubst %.html, %.pdf, $(SLIDES_HTML))
SLIDES_PDF:=$(addprefix pdf/, $(SLIDES_PDF))

PRINT:=$(filter $(wildcard *-print.Rmd), $(wildcard *.Rmd))
PRINT_HTML:=$(patsubst %.Rmd, %.html, $(PRINT))
PRINT_PDF:=$(patsubst %.html, %.pdf, $(PRINT_HTML))
PRINT_PDF:=$(addprefix pdf/, $(PRINT_PDF))

TEX:=$(wildcard *.tex)
HANDOUT:=$(patsubst %-handout.tex, %-handout.pdf, $(TEX))
HANDOUT:=$(addprefix pdf/, $(HANDOUT))

.PHONY : all
all : html pdf handout cleanup

# render RmD to html

html : $(SLIDES_HTML) $(PRINT_HTML)

%slides.html : %slides.Rmd 
	R -e 'rmarkdown::render("$<", output_file = "$@")'

%print.html : %print.Rmd 
	R -e 'rmarkdown::render("$<", output_file = "$@")'


# Convert html to pdf

pdf : $(SLIDES_PDF) $(PRINT_PDF)

pdf/%slides.pdf : %slides.html 
	R -e 'pagedown::chrome_print("$<", "$@")'

pdf/%print.pdf : %print.html 
	R -e 'pagedown::chrome_print("$<", "$@")'
	touch %.tex



# Create print version of slideshow

handout : $(HANDOUT)

pdf/%-handout.pdf : %-handout.tex pdf/%-print.pdf
	pdflatex -output-directory pdf $< 

# Remove temporary files used in building pdf 

.PHONY : cleanup
cleanup :
#	rm -f ./pdf/*-print.pdf
#	rm -f ./*-Print.html
	rm -f ./pdf/*.aux
	rm -f ./pdf/*.log
	
clean :
	rm -f ./*.html
	rm -f ./pdf/*.pdf

.INTERMEDIATE : $(PRINT_PDF) $(PRINT_HTML)
