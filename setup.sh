#!/bin/bash
# ===============================================
# @file    setup.sh
# @authors Derek Anderson
#          (derek.murphy.anderson@protonmail.com)
# -----------------------------------------------
# @brief Set up environment for running
#   demonstration. Can provide directory
#   to install virtual environment to
#   as an argument:
#
#       ./setup.sh .my_venv
# ===============================================

dir=".venv"
if [ $# -gt 0 ]; then
  dir=$1
fi

if [ ! -d "$dir" ]; then
  python -m venv $dir
fi
source $dir/bin/activate

# NOTE the snakemake install is to make
#   sure it uses the virtual environment
#   with cardio
pip install git+https://github.com/eic/cardio.git
pip install --ignore-installed snakemake

# if not done, retrieve relevant
# eic-shell to use
if [ ! -d "shell" ]; then
python - <<'PY'
import cardio
card = cardio.Card("template.yml")
card.get_shell("./shell")
PY
fi
