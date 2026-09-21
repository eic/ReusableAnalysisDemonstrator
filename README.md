# Reusable Analysis Demonstrator

This repository is intended as a proof-of-concept for using a generic
datacard to facilitate reusable analyses.  Central to the example is 
a simple Python module, `cardio`, which automates the creation and
reading from a YAML datacard.


### File Structures

```
+-- analysis
|    +-- MakeValidationHists.C # process eicrecon output to make hists
|    \-- MakeValidationPlots.C # make plots from output of *hists.C
+-- cardio.py # cardio implementation
+-- input.yml # example input datacard
+-- README.md # description, quickstart
+-- snake
|    +-- config.yml  # workflow constants
|    \-- profile.yml # slurm parameters for snakemake
+-- Snakefile    # snakemake workflow
+-- template.yml # template output datacard
```

### Usage

After updating any relevant options in `snake/*.yml`
and `Snakefile`, run in `eic-shell`:
```
Snakemake --cores <N> 
```
