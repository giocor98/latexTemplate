LATEXCOMPILER = pdflatex
BIBERCOMPILER = biber

REMOVE_FILES_COMMAND = rm -f *.log *.aux *.lof *.lot *.toc *.out *.fls *.fdb_latexmk *.bbl *.bcf *.blg *.run.xml


SRC_DIR = src

DELIVERABLES_DIR = deliverables

COMMON_DIR = src/common

FILE_DIR = Files

MAIN_PDF = main.pdf
MAIN_TEX = main.tex
MAIN_BIB = main.bib
MAIN = main


__COMMON = $(COMMON_DIR)/commandsFile.tex $(COMMON_DIR)/util/*




$(SRC_DIR)/$(MAIN_PDF): $(SRC_DIR)/$(MAIN_TEX) $(SRC_DIR)/$(FILE_DIR)/* $(__COMMON) $(SRC_DIR)/$(MAIN_BIB)
	cd $(SRC_DIR) && $(LATEXCOMPILER) $(MAIN_TEX) && $(BIBERCOMPILER) $(MAIN) && $(LATEXCOMPILER) $(MAIN_TEX)

$(DELIVERABLES_DIR)/$(MAIN_PDF): $(SRC_DIR)/$(MAIN_PDF)
	cp $(SRC_DIR)/$(MAIN_PDF) $(DELIVERABLES_DIR)/$(MAIN_PDF)

clean:
	$(REMOVE_FILES_COMMAND)
	cd $(SRC_DIR) && $(REMOVE_FILES_COMMAND)

uninstall: clean
	cd $(SRC_DIR) && rm -f *.pdf

all: $(SRC_DIR)/$(MAIN_PDF)

install: $(DELIVERABLES_DIR)/$(MAIN_PDF)
	make clean

update:
	make uninstall
	make clean
	make install
