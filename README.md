# Two-Agent-Heterogeneous-DSGE-Model
Repository for a Bayesian DSGE macroeconomic project implemented in MATLAB and Dynare.
The project includes multiple Dynare model files (.mod) defining the baseline model, detrended versions, and alternative specifications used for SMM and Bayesian estimation.
MATLAB scripts (build_DATA.m, build_DATA_DT.m) construct and preprocess macroeconomic datasets from raw inputs, including detrended series.
Additional MATLAB files generate impulse response functions, estimation outputs, and diagnostic plots.
Input datasets are stored in .mat format and documented for reproducibility.
The repository also contains auxiliary include files (.inc) used to modularize Dynare code across model variants.
An Excel file (data.xls) provides the original raw data used in the analysis.
The full theoretical derivation, model description, estimation strategy, and results are documented in Report (Latex)
