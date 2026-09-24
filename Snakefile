# ===============================================
# @file    Snakefile
# @authors Derek Anderson
#          (derek.murphy.anderson@protonmail.com)
# -----------------------------------------------
# @brief Example snakefile utilizing cardio to
#   extract input filelists, analysis rule and
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

# redeclare make_hists to specify input
rule make_hists:
    input:
        list = f"{config['input_list']}",

rule all:
    input:
        "out/plots/matchedJetResolutionVsEta.demo.png"

onsuccess:
    import cardio
    cardio.make_card(config['output_card'], config['template'])
