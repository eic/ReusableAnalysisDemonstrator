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

import sys
import cardio

icard = cardio.load_card(config['input_card'])
tcard = cardio.load_card(config['template'])
icard.dump_files(config['input_list'], protocol="rucio")
tcard.dump_rules(config['rules_file'])

include: config['rules_file']

rule all:
    input:
        "out/plots/matchedJetResolutionVsEta.demo.png"

onsuccess:
    import cardio
    cardio.make_card(config['output_card'], config['template'])
