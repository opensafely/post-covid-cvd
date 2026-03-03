# Load libraries ----
print('Load libraries')

library(magrittr)

# Specify paths ----
print('Specify paths')

source("analysis/specify_paths.R")
source("analysis/utility.R")

# Source common functions ----
print('Source common functions')

lapply(
  list.files("analysis/post_release/", full.names = TRUE, pattern = "fn-"),
  source
)

# Make Venn diagrams ----
print('Make Venn diagrams')

source("analysis/post_release/plot-venn.R")

# Make HR plot data ----
print('Make HR plot data')

model_output <- unname(unlist(mget(ls(pattern = "path_model_output"))))
make_hr_data(model_output = model_output)

# Make all HR plots ----
print('Make all HR plots')

source("analysis/post_release/plot-HR.R")

# Make Table 1 ----
print('Make Table 1')

source("analysis/post_release/table-1.R")

# Make Table 2 ----
print('Make Table 2')

source("analysis/post_release/table-2.R")

# Make Table 3 ----
print('Make Table 3')

source("analysis/post_release/table-3.R")

# Run absolute excess risk analyses ----
print('Run absolute excess risk analyses')

source("analysis/post_release/lifetables_compiled.R")

make_AER_plot(
  outcomes = c("ate", "vte"),
  name = "composite_outcomes",
  at_day = 364
)

source("analysis/post_release/table-AER.R")

# Make flow output table ----
print('Make flow output table')

source("analysis/post_release/table-flow_output.R")
