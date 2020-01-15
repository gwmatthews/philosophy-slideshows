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
all : html pdf print handout cleanup

.PHONY : test
test :
	@echo TEX: $(TEX)
	@echo HANDOUT: $(HANDOUT)

html : $(SLIDES_HTML) 

pdf : $(SLIDES_PDF)

print: $(PRINT_PDF)

handout : $(HANDOUT) $(PRINT_PDF) $(PRINT_HTML)

# render RmD to html

%slides.html : %slides.Rmd 
	R -e 'rmarkdown::render("$<", output_file = "$@")'

%print.html : %print.Rmd
	R -e 'rmarkdown::render("$<", output_file = "$@")'

# Convert html to pdf

pdf/%slides.pdf : %slides.html %print.html
	R -e 'pagedown::chrome_print("$<", "$@")'

pdf/%print.pdf : %print.html
	R -e 'pagedown::chrome_print("$<", "$@")'

# Create print version of slideshow

pdf/%-handout.pdf : %-handout.tex pdf/%-print.pdf
	pdflatex -output-directory pdf $< 

# Remove temporary files used in building pdf 

.PHONY : cleanup
cleanup :
	rm -f ./pdf/*.aux
	rm -f ./pdf/*.log
	@echo Everything is up to date.	

clean :
	rm -f ./*.html
	rm -f ./pdf/*.pdf

.SECONDARY : $(PRINT_PDF) $(PRINT_HTML)

