# Reusable Analysis Demonstrator

This repository is intended as a proof-of-concept for using a generic
data card to facilitate reusable analyses.  Central to the example is
a simple Python module, [`cardio`](https://github.com/eic/cardio/tree/main),
which automates the creation and reading from a YAML data card.

### File Structures

```
|-- analysis
|     |-- MakeValidationHists.C # process eicrecon output to make hists
|     `-- MakeValidationPlots.C # make plots from output of *hists.C
|-- cardio.py  # cardio implementation
|-- config.yml # snakemake workflow parameters
|-- input.yml  # example input data card
|-- README.md  # description, quickstart
|-- scripts
|     |- cleanup.sh         # remove run/output directories
|     `- full_snakemake.smk # Snakefile to run pipeline without cards
|-- Snakefile    # snakemake workflow
`-- template.yml # template output data card
```

### Demonstrator

The following workflow demonstrates how these cards can be used for
reproducibility in a Snakemake workflow.  This should be run
inside [`eic-shell`](https://eic.github.io/tutorial-setting-up-environment/).

1. Setup virtual environment (this may take a few minutes).
```
./setup.sh
```

2. Perform initial run:
```
.venv/bin/snakemake --cores 1 --config hist_out="out_0" plot_out="out_0/plot"
```

3. Rerun using the 1st output card as a new template:
```
.venv/bin/snakemake --cores 1 --config hist_out="out_1" plot_out="out_1/plot" template="out_0/output.yml"
```

4. Inspect the output from both runs to see that they're the same.
