# 
# Resume
# Makefile
#

# paths
TEMPLATE = src/index.tex.j2
CONTENT = src/content.json
INDEX_TEX = src/index.tex

# programs
JINJA2 = jinja2
TEX_BUILD = tectonic

# Target to generate the index.tex file from the template
$(INDEX_TEX): $(TEMPLATE) $(CONTENT)
	$(JINJA2) $(TEMPLATE) $(CONTENT) > $(INDEX_TEX)

# Target to build the LaTeX document using Tectonic
build: $(INDEX_TEX)
	$(TEX_BUILD) -X build

.PHONY: build
