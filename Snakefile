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

# prestart: generate input, rules ---------------

import cardio
tcard = cardio.load_card(config['template'])
icard = tcard.input()
tcard.dump_rules(config['rules_file'], config['config_file'])
icard.dump_files(config['input_list'], protocol="rucio")

# startup: make output dirs ---------------------

onstart:
    import os
    os.makedirs(config['hist_out'], exist_ok=True)
    os.makedirs(config['plot_out'], exist_ok=True)

# run workflow ----------------------------------

include: config['rules_file']

rule all:
    input:
        f"{config['plot_out']}/matchedJetResolutionVsEta.{config['suffix']}.png"

# shutdown: write output card ------------------

onsuccess:
    import cardio
    card_name = config['hist_out'] + "/" + config['card_name']
    cardio.make_card(card_name, config['template'], config['hist_out'])
