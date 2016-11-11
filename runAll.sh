#!/bin/bash
# Submits LSF jobs for each file in input folder
# Output tables written to cibersort_freq

account="acc_STARNET"  # LSF account

for file in input/*; do
	bsub -J CIBERSORT \
		-P $account \
		-q alloc \
		-W 12:00 \
		-n 4 \
		-e logs/error.%J \
		-o logs/output.%J \
		runCibersort.r -l lib \
			-b basis/LM22.tsv \
			-o cibersort_freq \
			$file
done
