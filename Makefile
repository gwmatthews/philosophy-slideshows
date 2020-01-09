FILES=01-introduction.html 01-introduction.pdf 01-Print.pdf 01-introduction-print.pdf \
02-religion.html 02-religion.pdf 02-Print.pdf 02-religion-print.pdf \


all : $(FILES)
	echo All files are now up to date
	
cleantex :
	rm -f ./pdf/*.log
	rm -f ./pdf/*.synctex.gz
	rm -f ./pdf/*.aux
	rm -f ./pdf/*-Print.pdf
	
clean :
	rm -f ./*.html
	rm -f ./pdf/*.pdf

%.html : %.Rmd
	R -e 'rmarkdown::render("$<", output_file = "$@")'

%.pdf : %.html
	R -e 'pagedown::chrome_print("$<", "pdf/$@")'

%.pdf : %.tex
	pdflatex -output-directory pdf $< 
	
