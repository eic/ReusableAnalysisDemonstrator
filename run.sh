#!/bin/bash
# ===============================================
# @file    run.sh
# @authors Derek Anderson
#          (derek.murphy.anderson@protonmail.com)
# -----------------------------------------------
# @brief Run to do demonstration
# ===============================================

# Run 0: use template.yml to do initial run
.venv/bin/snakemake --cores 1 --config hist_out="out_0" plot_out="out_0/plot"

# Run 1: use out_0/output.yml to rerun
.venv/bin/snakemake --cores 1 --config hist_out="out_1" plot_out="out_1/plot" template="out_0/output.yml"
