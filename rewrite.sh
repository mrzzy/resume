#!/bin/bash
# 
# Resume
# Makefile
# Rewrite Resume with Libreoffice for better compatibility
#
set -uex -o pipefail

# location of the bind mount of the working directory into the libreoffice container
BIND_DIR=/work
# relative path of the raw pdf to be rewritten
PDF_RAW=${BIND_DIR}/${1:-build/resume/resume_raw.pdf}
# relative output directory to rewrite resume
PDF_DIR=$(dirname ${PDF_RAW})

# convert to docx
libreoffice \
		--headless \
		--infilter=="writer_pdf_import" \
		--convert-to odt:"writer8" \
		--outdir ${PDF_DIR} \
		${PDF_RAW}

mv ${PDF_DIR}/resume_raw.odt ${PDF_DIR}/resume.odt

# rewrite as pdf
libreoffice \
		--headless \
		--convert-to pdf:"writer_pdf_Export" \
		--outdir ${PDF_DIR} \
		${PDF_DIR}/resume.odt
