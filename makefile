#
# Resume
# Makefile
#

.PHONY: sync-readme

REF_SUFFIX_PATTERN:="s|[-_[:alpha:]]+/||g; s|[/-]|_|g"
REF_SUFFIX:=$(shell git branch --show-current | sed -Ee $(REF_SUFFIX_PATTERN))

# sync preview PNG URL on README with git's current branch
sync-readme: README.md
	sed -Ee 's/[-_[:alpha:]]+-1\.png/$(REF_SUFFIX)-1.png/' $< >$<.tmp
	mv $<.tmp $<
