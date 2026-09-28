# ===============================================
# @file    Snakefile
# @authors Derek Anderson
#          (derek.murphy.anderson@protonmail.com)
# -----------------------------------------------
# @brief Example snakefile utilizing cardio to
#   extract input filelists, analysis rules and
#   run them.
# ===============================================

configfile: "config.yml"

# setup -----------------------------------------

import os
import sys
import cardio

tcard = cardio.load_card(config['template'])
icard = tcard.input()
tcard.dump_rules(config['rules_file'])
icard.dump_files(config['input_list'], protocol="rucio")

os.makedirs("out/plots", exist_ok=True)

# run workflow ----------------------------------

include: config['rules_file']

rule all:
    input:
        "out/plots/matchedJetResolutionVsEta.demo.png"

onsuccess:
    import cardio
    cardio.make_card(config['output_card'], config['template'])
