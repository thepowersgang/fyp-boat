
all: 01-Proposal.pdf

%.pdf: %.tex template.tex
	@mkdir -p .out
	pdflatex -output-directory .out $< -draft
	@pdflatex -output-directory .out $<
	@cp .out/$(notdir $@) $@

