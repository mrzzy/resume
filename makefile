# 
# Resume
# Makefile
#
.DEFAULT: build
.PHONY: build

# paths
TEMPLATE = src/index.tex.j2
CONTENT = src/content.json
INDEX_TEX = src/index.tex
PDF = build/resume/resume.pdf

# programs
JINJA2 = jinja2
TEX_BUILD = tectonic

build: $(PDF)

# Target to build the LaTeX document using Tectonic
$(PDF): $(INDEX_TEX)
	$(TEX_BUILD) -X build


# Target to generate the index.tex file from the template
$(INDEX_TEX): $(TEMPLATE) $(CONTENT)
	$(JINJA2) $(TEMPLATE) $(CONTENT) > $(INDEX_TEX)

