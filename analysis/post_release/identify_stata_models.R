stata_threshold_lower <- 2^-3
stata_threshold_upper <- 2^5.5

# Load model output ----

df <- data.table::fread("output/post_release/model_output.csv")

# Filter model output ----

df <- df[
  !(df$term %in% c("days_pre", "days0_1")) &
    df$model == "mdl_max_adj",
]

# Idenitfy models to run in Stata ----

run_stata <- unique(
  df[(df$hr > stata_threshold_upper) | (df$hr < stata_threshold_lower), ]$name
)
