#!/bin/bash

# Calculate a standardized relatedness matrix
gemma -bfile famEpilepsy -gk 2 -o relatednessMatrix 

# Perform Eigen-Decomposition of the relatedness matrix
gemma -bfile famEpilepsy -k output/relatednessMatrix.sXX.txt -eigen -o eigenResult

# Perform association tests with univariate linear mixed models and the wald test
#gemma -bfile famEpilepsy -k output/relatednessMatrix.sXX.txt -lmm 1 -o waldResult
gemma -bfile famEpilepsy -d output/eigenResult.eigenD.txt -u output/eigenResult.eigenU.txt -lmm 1 -o waldResult 

