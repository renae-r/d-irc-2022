# Install ipumsr (just once) ---------------------------------------------
install.packages("ipumsr")


# Load ipumsr (every time) ------------------------------------------------
library(ipumsr)


# Set API key -------------------------------------------------------------
set_ipums_api_key("paste-your-key-here")


# Define your extract -----------------------------------------------------
extract <- define_extract_cps(
  description = "Employment status 2018-2019",
  samples = c("cps2019_03s"),
  variables = c("AGE", "SEX", "EMPSTAT")
)

# CPS sample IDs:
#   https://cps.ipums.org/cps-action/samples/sample_ids


# Submit and wait for extract ---------------------------------------------
extract <- submit_extract(extract)
extract
extract <- wait_for_extract(extract)


# Download extract --------------------------------------------------------
ddi_path <- download_extract(extract)


# Read in your data -------------------------------------------------------
data <- read_ipums_micro(ddi_path)


# All in one piped expression ---------------------------------------------
library(magrittr) # for the %>% (pipe) operator

data <- extract %>% 
  submit_extract() %>% 
  wait_for_extract() %>% 
  download_extract() %>% 
  read_ipums_micro()
