#!/bin/bash
# Submits LSF jobs for each file in input folder
# Output tables written to cibersort_freq
# Must be executed in root folder.

account="acc_STARNET"  # LSF account

module load rstudio

for file in input/*; do
	bsub -J CIBERSORT \
		-P $account \
		-q alloc \
		-W 48:00 \
		-n 4 \
		-R rusage[mem=1000]
		-e logs/error.%J \
		-o logs/output.%J \
		./runCibersort.r -l lib \
			-b basis/primary_cells_svm_2942_aggregate.tsv \
			-o out_freq \
			$file
done
