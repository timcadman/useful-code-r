################################################################################
## Project: useful-code-r
## Script purpose: Neat cohort names for LifeCycle scripts
## Date: 31.05.21
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################
library(tibble)

names_neat <- tibble(
  cohort = c(
    "abcd", "alspac", "bib", "chop", "dnbc", "eden", "eden_nan", "eden_poit", "elfe", 
    "gecko", "genr", "hgs", "inma", "inma_gip", "inma_sab", "inma_val", "moba", 
    "ninfea", "nfbc66", "nfbc86", "raine", "rhea", "sws", "combined"),
  cohort_neat = c(
    "ABCD", "ALSPAC", "BiB", "CHOP", "DNBC", "EDEN", "EDEN Nancy", "EDEN Poitiers", 
    "ELFE", "GECKO", "GENR", "HGS", "INMA", "INMA Gipuzkoa", "INMA Sabadell", 
    "INMA Valencia", "MoBa", "NINFEA", "NFBC66", "NFBC86", "Raine", "RHEA", "SWS", 
    "Combined"), 
  country = c(
    "Netherlands", "UK", "UK", "Multiple", "Denmark", "France", "France", "France", 
    "France", "Netherlands", "Netherlands", "Greece", "Spain", "Spain", "Spain", 
    "Spain", "Norway", "Italy", "Finland", "Finland", "Australia", "Greece", "UK", 
    ""))