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

1. Set up your virtual environment and download the relevant
   EIC shell (this may take a few minutes).

```
./setup.sh .venv_out
```

Note that the argument is the directory to install a python
virtual environment in.

2. Activate the downloaded EIC shell:

```
./shell/eic-shell
```

3. Install `cardio` to another virtual environment inside
   the shell (this step won't be necessary once `cardio`
   is part of the shell):

```
./setup.sh .venv_in
```

4. Run the workflow twice with:

```
./run.sh
```

5. Insepct the output from both runs to see that they're
   the same.

---

Step 4 will run two process. First, it will run
sing the default template card to define everything:

```
.venv_in/bin/snakemake \
  --cores 1 \
  --config hist_out="out_1" plot_out="out_1/plot"
```

Then, it reruns the workflow using the output card as
a new template:

```
.venv_in/bin/snakemake \
  --cores 1 \
  --config hist_out="out_2" plot_out="out_2/plot" template="out_1/output.yml"
```
