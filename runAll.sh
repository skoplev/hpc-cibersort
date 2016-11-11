#!/bin/bash
# Submits LSF jobs for each file in input folder
# Output tables written to cibersort_freq

account="acc_STARNET"  # Minerva account

for file in input/*; do
	gsub -J CIBERSORT \
		-P $account \
		-q alloc \
		-W 12:00 \
		-n 4 \
		-e logs/error.%J \
		-o logs/output.%J \
		runCibersort.r -l lib \
			-b basis/sig.tsv \
			-o cibersort_freq \
			$file
done