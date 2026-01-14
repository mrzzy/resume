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
PDF = build/resume/resume.pdf

# programs
JINJA2 = jinja2
TEX_BUILD = tectonic
RM = rm 

build: $(PDF)

# Target to generate the index.tex file from the template
# escape & as \& as '&" is a special character in resume
# skip first 11 lines as header tex relies on unescaped '&' character
N_ESCAPE= 12
$(INDEX_TEX): $(TEMPLATE) $(CONTENT)
	$(JINJA2) $(TEMPLATE) $(CONTENT) | sed '$(N_ESCAPE),$$s/&/\\&/g' > $(INDEX_TEX)

# Target to build the LaTeX document into PDF using Tectonic
$(PDF): $(INDEX_TEX)
	$(TEX_BUILD) -X build

clean:
	$(RM) -rf build
