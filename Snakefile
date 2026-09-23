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

rule get_file_list:
    output:
        list = f"{config['input_list']}",
    run:
        import cardio
        in_card = cardio.load_card(config['input_card'])
        in_card.dump_files(output.list, protocol="rucio")

rule make_hists:
    input:
        list = f"{config['input_list']}",
    output:
        hist = "out/output.root",
    shell:
        "root -b -q analysis/MakeJetValidationHists.C\'(\"{output.hist}\", \"{input.list}\", 1, 100)\'"

rule make_plots:
    input:
        hist = "out/output.root",
    output:
        plot = "out/plots/matchedJetResolutionVsEta.demo.png",
    params:
        path = "out/plots",
        suff = "demo",
    shell:
      "root -b -q analysis/MakeJetValidationPlots.C\'(\"{params.path}\", \"{params.suff}\", \"{input.hist}\")\'"

rule all:
    input:
        "out/plots/matchedJetResolutionVsEta.demo.png"

onsuccess:
    import cardio
    cardio.make_card(config['output_card'], config['template'])
