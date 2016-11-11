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
		-W 24:00 \
		-n 4 \
		-e logs/error.%J \
		-o logs/output.%J \
		./runCibersort.r -l lib \
			-b basis/primary_cells_svm_2942_aggregate.tsv \
			-o cibersort_freq \
			$file
done
