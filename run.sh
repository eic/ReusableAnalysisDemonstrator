#!/bin/bash
# ===============================================
# @file    run.sh
# @authors Derek Anderson
#          (derek.murphy.anderson@protonmail.com)
# -----------------------------------------------
# @brief Run to do demonstration
# ===============================================

# Update if using a different environment
#   directory than README suggests
venv=".venv_in"

# Run 1: use template.yml to do initial run
$venv/bin/snakemake \
  --cores 1 \
  --config \
    input_list="run_1/input.list" \
    rules_file="run_1/rules.yml" \
    run_dir="run_1" \
    hist_out="out_1" \
    plot_out="out_1/plot"

# Run 2: use out_0/output.yml to rerun
$venv/bin/snakemake \
  --cores 1 \
  --config \
    input_list="run_2/input.list" \
    rules_file="run_2/rules.yml" \
    run_dir="run_2" \
    hist_out="out_2" \
    plot_out="out_2/plot" \
    template="out_1/output.yml"
