#!/bin/bash
# ===============================================
# @file    setup.sh
# @authors Derek Anderson
#          (derek.murphy.anderson@protonmail.com)
# -----------------------------------------------
# @brief Run to set up environment for test
# ===============================================

if [ ! -d ".venv" ]; then
  python -m venv .venv
fi
source .venv/bin/activate

# NB the snakemake install is to make sure
#   it uses the virtual environment
pip install git+https://github.com/eic/cardio.git@get-pip-install-working
pip install --ignore-installed snakemake
