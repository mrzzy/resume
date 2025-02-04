# 
# Resume
# Makefile
#
.DEFAULT: build
.PHONY: build clean

# paths
TEMPLATE = src/index.tex.j2
CONTENT = src/content.json
INDEX_TEX = src/index.tex
PDF_RAW = build/resume/resume_raw.pdf
PDF = build/resume/resume.pdf

# programs
JINJA2 = jinja2
TEX_BUILD = tectonic
MV = mv
DOCKER = docker
RM = rm 

build: $(PDF)

# Target to generate the index.tex file from the template
$(INDEX_TEX): $(TEMPLATE) $(CONTENT)
	$(JINJA2) $(TEMPLATE) $(CONTENT) > $(INDEX_TEX)

# Target to build the LaTeX document into PDF using Tectonic
$(PDF_RAW): $(INDEX_TEX)
	$(TEX_BUILD) -X build
	$(MV) $(PDF) $(PDF_RAW)

# Rewrite the resume PDF with libreoffice for better compatibility
$(PDF): $(PDF_RAW)
	$(DOCKER) run -v $(shell pwd):/work lscr.io/linuxserver/libreoffice bash /work/rewrite.sh
	
clean:
	$(RM) -rf build
