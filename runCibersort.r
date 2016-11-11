#!/usr/bin/env Rscript
#
# Wrapper for running CIBERSORT.R by command line.
# CIBERSORT.R uses 3 parallel threads.
# Note: writes CIBERSORT-Results.txt file to working directory

library(optparse)

# Command line arguments 
opt_list = list(
	make_option(c("-l", "--library"),
		type="character",
		default=".",
		help="Folder containing CIBERSORT.R source code. Access is distributed through cibersort.stanford.edu"),
	make_option(c("-b", "--basis"),
		type="character",
		default=NULL,
		help=".tsv file containing gene expression matrix of basis cell types."),
	make_option(c("-o", "--output"),
		type="character",
		default="cibersort_output",
		help="Output folder.")
)

opt_parser = OptionParser(
	option_list=opt_list,
	usage="%prog [options] expr_file")

opt = parse_args(opt_parser, positional_arguments=1)

expr_file = opt$args[1]

# Load CIBERSORT source code
source(file.path(opt$options$library, "CIBERSORT.R"))

# Run CIBERSORT
results = CIBERSORT(
	opt$options$basis,  # path to basis expression file
	expr_file  # expression file
)

# Write output to file
dir.create(opt$options$output)  # create output folder

write.table(results,
	file.path(opt$options$output,
		paste0(
			strsplit(basename(expr_file), "[.]")[[1]][1],  # base file name without extension
			".tsv")),
	sep="\t",
	quote=FALSE)
