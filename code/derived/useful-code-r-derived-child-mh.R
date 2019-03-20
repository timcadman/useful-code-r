################################################################################
## Project: useful-code-r
## Script purpose: Derive ALSPAC child mental health variables
## Date: 7th March 2019
## Author: Tim Cadman
## Email: t.cadman@bristol.ac.uk
################################################################################

# Derives total prorated scores for:
# 
# 1. SDQ internalising scale
# 2. SDQ externalising scale
# 3. MFQ
# 4. CIS-R
#
# Following suffixes refer to the rater:
# _mat: maternal rated
# _sch: teacher rated
# _chi: child rated (self-report)
# 
# SDQ scores were already pro-rated. Pro-rating of MFQ done via a function I
# wrote.

source("./useful-code-r/code/functions/proRate.R")

library(alspac)
library(dplyr)
library(Hmisc)

data(current)

################################################################################
# 1. Get data 
################################################################################
chi_mh.varlist <- subset(current, name %in% c("ta5020", "ta5021", "ta5022", 
                  "ta5023", "ta5024", "ta5025", "ta5026", "ta5027", "ta5028", 
                  "ta5029", "ta5030", "ta5031", "ta5032", "tc4030", "tc4031", 
                  "tc4032", "tc4033", "tc4034", "tc4035", "tc4036", "tc4037", 
                  "tc4038", "tc4039", "tc4040", "tc4041", "tc4042", "fddp110", 
                  "fddp112", "fddp113", "fddp114", "fddp115", "fddp116", 
                  "fddp118", "fddp119", "fddp121", "fddp122", "fddp123", 
                  "fddp124", "fddp125", "ff6500", "ff6502", "ff6503", "ff6504", 
                  "ff6505", "ff6506", "ff6508", "ff6509", "ff6511", "ff6512", 
                  "ff6513", "ff6514", "ff6515", "fg7210", "fg7212", "fg7213", 
                  "fg7214", "fg7215", "fg7216", "fg7218", "fg7219", "fg7221", 
                  "fg7222", "fg7223", "fg7224", "fg7225", "ccs4500", "ccs4502", 
                  "ccs4503", "ccs4504", "ccs4505", "ccs4506", "ccs4508", 
                  "ccs4509", "ccs4511", "ccs4512", "ccs4513", "ccs4514", 
                  "ccs4515", "CCXD900", "CCXD902", "CCXD903", "CCXD904", 
                  "CCXD905", "CCXD906", "CCXD908", "CCXD909", "CCXD911", 
                  "CCXD912", "CCXD913", "CCXD914", "CCXD915", "cct2700", 
                  "cct2701", "cct2702", "cct2703", "cct2704", "cct2705", 
                  "cct2706", "cct2707", "cct2708", "cct2709", "cct2710", 
                  "cct2711", "cct2712", "YPA2000", "YPA2010", "YPA2020", 
                  "YPA2030", "YPA2040", "YPA2050", "YPA2060", "YPA2070", 
                  "YPA2080", "YPA2090", "YPA2100", "YPA2110", "YPA2120", 
                  "YPB5000", "YPB5010", "YPB5030", "YPB5040", "YPB5050", 
                  "YPB5060", "YPB5080", "YPB5090", "YPB5100", "YPB5120", 
                  "YPB5130", "YPB5150", "YPB5170", "YPC1650", "YPC1651", 
                  "YPC1653", "YPC1654", "YPC1655", "YPC1656", "YPC1658", 
                  "YPC1659", "YPC1660", "YPC1662", "YPC1663", "YPC1665", 
                  "YPC1667", "j557a", "j557d", "kq348c", "kq348e", "n8365a", 
                  "n8365d", "ku673b", "ku707b", "ku709b", "kw6100b", "kw6602b", 
                  "kw6604b", "ta7025a", "ta7025d", "tc4025a", "tc4025d", 
                  "sa163b", "sa165b", "se163b", "se165b", "j557b", "j557c", 
                  "kq348d", "kq348b", "n8365b", "n8365c", "ku708b", "ku706b", 
                  "kw6603b", "kw6601b", "ta7025b", "ta7025c", "tc4025b", 
                  "tc4025c", "sa164b", "sa162b",  "se164b", "se162b", "FJCI602", 
                  "FJCI604", "FJCI605", "FJCI606", "FJCI001", "FJCI369", 
                  "FJCI1001", "fd003c", "ff0011a", "fg0011a", "ccs9991a", 
                  "CCXD006", "cct9991a", "YPA9020", "YPB9992", "YPC2650"))

chi_mh_mast.data <- extractVars(chi_mh.varlist)

chi_mh.data <- chi_mh_mast.data

################################################################################
# 2. Create variable lists  
################################################################################
mfq.ta.vars  <- c("ta5020", "ta5021", "ta5022", "ta5023", "ta5024", "ta5025", 
                 "ta5026", "ta5027", "ta5028", "ta5029", "ta5030", "ta5031", 
                 "ta5032")
mfq.tc.vars  <- c("tc4030", "tc4031", "tc4032", "tc4033", "tc4034", "tc4035",
                 "tc4036", "tc4037", "tc4038", "tc4039", "tc4040", "tc4041", 
                 "tc4042")
mfq.fd.vars  <- c("fddp110", "fddp112", "fddp113", "fddp114", "fddp115",
                 "fddp116", "fddp118", "fddp119", "fddp121", "fddp122", 
                 "fddp123", "fddp124", "fddp125")
mfq.ff.vars  <- c("ff6500", "ff6502", "ff6503", "ff6504", "ff6505", "ff6506", 
                 "ff6508", "ff6509", "ff6511", "ff6512", "ff6513", "ff6514", 
                 "ff6515")
mfq.fg.vars  <- c("fg7210", "fg7212", "fg7213", "fg7214", "fg7215", "fg7216", 
                 "fg7218", "fg7219", "fg7221", "fg7222", "fg7223", "fg7224", 
                 "fg7225")
mfq.ccs.vars <- c("ccs4500", "ccs4502", "ccs4503", "ccs4504", "ccs4505", 
                  "ccs4506", "ccs4508", "ccs4509", "ccs4511", "ccs4512", 
                  "ccs4513", "ccs4514", "ccs4515")
mfq.ccx.vars <- c("CCXD900", "CCXD902", "CCXD903", "CCXD904", "CCXD905", 
                  "CCXD906", "CCXD908", "CCXD909", "CCXD911", "CCXD912", 
                  "CCXD913", "CCXD914", "CCXD915")
mfq.cct.vars <- c("cct2700", "cct2701", "cct2702", "cct2703", "cct2704", 
                  "cct2705", "cct2706", "cct2707", "cct2708", "cct2709", 
                  "cct2710", "cct2711", "cct2712")
mfq.ypa.vars <- c("YPA2000", "YPA2010", "YPA2020", "YPA2030", "YPA2040", 
                  "YPA2050", "YPA2060", "YPA2070", "YPA2080", "YPA2090", 
                  "YPA2100", "YPA2110", "YPA2120")
mfq.ypb.vars <- c("YPB5000", "YPB5010", "YPB5030", "YPB5040", "YPB5050", 
                  "YPB5060", "YPB5080", "YPB5090", "YPB5100", "YPB5120", 
                  "YPB5130", "YPB5150", "YPB5170")
mfq.ypc.vars <- c("YPC1650", "YPC1651", "YPC1653", "YPC1654", "YPC1655", 
                  "YPC1656", "YPC1658", "YPC1659", "YPC1660", "YPC1662", 
                  "YPC1663", "YPC1665", "YPC1667")

################################################################################
# 3. Recode items and set missing values  
################################################################################
chi_mh.data <- chi_mh.data %>%
  mutate_if(is.numeric, 
  funs(ifelse( . < 0 | . == 9, NA, .)))

chi_mh.data <- chi_mh.data %>%
  mutate_at(vars(mfq.ta.vars, mfq.tc.vars, mfq.fd.vars, mfq.ff.vars, 
    mfq.fg.vars, mfq.ccs.vars, mfq.ccx.vars, mfq.cct.vars, mfq.ypa.vars), 
  funs(3 - .))

chi_mh.data <- chi_mh.data %>%
  mutate_at(vars(mfq.ypb.vars, mfq.ypc.vars),
  funs(. - 1))

################################################################################
# 3. Derive variables  
################################################################################

## ---- SDQ Internalising ------------------------------------------------------
chi_mh.data <- chi_mh.data %>%
mutate(
   sqd_int_3_mat = j557a + j557d,
   sdq_int_6_mat = kq348c + kq348e, 
   sdq_int_8_mat = n8365a + n8365d, 
   sdq_int_9_mat = ku707b + ku709b, 
   sdq_int_11_mat = kw6602b + kw6604b, 
   sdq_int_13_mat = ta7025a + ta7025d, 
   sdq_int_16_mat = tc4025a + tc4025d, 
   sdq_int_8_sch = sa163b + sa165b, 
   sdq_int_11_sch = se163b + se165b)
   
## ---- Externalising ----------------------------------------------------------
chi_mh.data <- chi_mh.data %>%
mutate(sqd_ext_3_mat = j557b + j557c, 
         sqd_ext_6_mat = kq348d + kq348b, 
         sqd_ext_8_mat = n8365b + n8365c, 
         sqd_ext_9_mat = ku708b + ku706b, 
         sqd_ext_11_mat = kw6603b + kw6601b, 
         sqd_ext_13_mat = ta7025b + ta7025c, 
         sqd_ext_16_mat = tc4025b + tc4025c, 
         sqd_ext_8_sch = sa164b + sa162b, 
         sqd_ext_11_sch = se164b + se162b)

## ---- MFQ -------------------------------------------------------------------- 
chi_mh.data <- chi_mh.data %>%
mutate(
mfq_10_chi = proRate(chi_mh.data, mfq.fd.vars, 0),
mfq_12_chi = proRate(chi_mh.data, mfq.ff.vars, 0),
mfq_13_chi = proRate(chi_mh.data, mfq.fg.vars, 0),
mfq_16_chi = proRate(chi_mh.data, mfq.ccs.vars, 0), 
mfq_17_chi = proRate(chi_mh.data, mfq.ccx.vars, 0),
mfq_18_chi = proRate(chi_mh.data, mfq.cct.vars, 0),
mfq_21_chi = proRate(chi_mh.data, mfq.ypa.vars, 0),
mfq_22_chi = proRate(chi_mh.data, mfq.ypb.vars, 0),
mfq_23_chi = proRate(chi_mh.data, mfq.ypc.vars, 0), 
mfq_9_mat = ku673b, 
mfq_11_mat = kw6100b, 
mfq_13_mat = proRate(chi_mh.data, mfq.ta.vars, 0), 
mfq_16_mat = proRate(chi_mh.data, mfq.tc.vars, 0),
mfq_10_chi_age = fd003c,
mfq_12_chi_age = ff0011a,
mfq_13_chi_age = fg0011a,
mfq_16_chi_age = ccs9991a,
mfq_17_chi_age = CCXD006,
mfq_18_chi_age = cct9991a,
mfq_21_chi_age = YPA9020,
mfq_22_chi_age = YPB9992,
mfq_23_chi_age= YPC2650)


## ---- CIS-R ------------------------------------------------------------------

# Participants coded as meeting criteria for an anxiety disorder if they 
# meet criteria for either (i) Generalised anxiety disorder, 
# (ii) Panic disorder, (iii) Agoraphobia, or (iv) Social phobia.

chi_mh.data <- chi_mh.data %>%
mutate(
   cisr_anx_18 = factor(
                ifelse(FJCI602 == 1 | FJCI604 == 1 | FJCI605 == 1 | 
                       FJCI606 ==1, 1, 0),
                labels = c("Yes", "No")),
   cisr_selfharm_18 = factor(
                     ifelse(FJCI369 == 1, 0, 1),
                     labels = c("No", "Yes")),
   cisr_dep_18 = factor(FJCI1001,
                    labels = c("No", "Yes")))

################################################################################
# 4. Drop original variables  
################################################################################
chi_mh.data <- chi_mh.data %>%
select(aln, qlet, sqd_int_3_mat, sdq_int_6_mat, sdq_int_8_mat, sdq_int_9_mat, 
       sdq_int_11_mat, sdq_int_13_mat, sdq_int_16_mat, sdq_int_8_sch, 
       sdq_int_11_sch, sqd_ext_3_mat, sqd_ext_6_mat, sqd_ext_8_mat, 
       sqd_ext_9_mat, sqd_ext_11_mat, sqd_ext_13_mat, sqd_ext_16_mat, 
       sqd_ext_8_sch, sqd_ext_11_sch, mfq_10_chi, mfq_12_chi, mfq_13_chi, 
       mfq_16_chi, mfq_17_chi, mfq_18_chi, mfq_21_chi, mfq_22_chi, mfq_23_chi, 
       mfq_9_mat, mfq_11_mat, mfq_13_mat, mfq_16_mat, cisr_anx_18, 
       cisr_selfharm_18, cisr_dep_18, mfq_10_chi_age, mfq_12_chi_age, 
       mfq_13_chi_age, mfq_16_chi_age, mfq_17_chi_age, mfq_18_chi_age, 
       mfq_21_chi_age, mfq_22_chi_age, mfq_23_chi_age)

save(chi_mh.data, file = "z:/projects/ieu2/p6/021/working/data/chi_mh.RData")