# Load data --------------------------------------------------------------------
print("Load data")

df <- readr::read_csv(
  "output/post_release/model_output.csv",
  show_col_types = FALSE
)

# Filter data ------------------------------------------------------------------
print("Filter data")

df <- df[grepl("days", df$term), ]

df <- df[
  ((df$model == "mdl_max_adj") |
    (df$model == "mdl_age_sex" & df$analysis == "main")),
  c(
    "analysis",
    "cohort",
    "outcome",
    "term",
    "model",
    "hr",
    "conf_low",
    "conf_high"
  )
]

df <- df[df$term != "days_pre", ]

df$analysis <- ifelse(
  df$model == "mdl_age_sex",
  "main-age_sex_adj",
  df$analysis
)
df$model <- NULL

# Add less than 50 events ------------------------------------------------------
print("Add less than 50 events")

tmp <- readr::read_csv(
  "output/post_release/model_output.csv",
  show_col_types = FALSE
)

tmp <- tmp[!is.na(tmp$error), colnames(df)]

if (nrow(tmp) > 0) {
  tmp$term <- NULL

  tmp2 <- unique(df[, c("cohort", "analysis", "term")])
  tmp <- merge(tmp, tmp2, by = c("cohort", "analysis"))

  tmp$hr <- "X"

  df <- rbind(df, tmp)
}

# Add plot labels --------------------------------------------------------------
print("Add plot labels")

plot_labels <- readr::read_csv("lib/plot_labels.csv", show_col_types = FALSE)
plot_labels <- rbind(
  plot_labels,
  c("main-age_sex_adj", "", "main-age_sex_adj", NA, 1.5)
)
plot_labels$ref <- as.numeric(plot_labels$ref)
plot_labels$ref_group <- as.numeric(plot_labels$ref_group)

## Outcome

df <- merge(
  df,
  plot_labels[, c("term", "label")],
  by.x = "outcome",
  by.y = "term",
  all.x = TRUE
)

df <- dplyr::rename(df, "outcome_label" = "label")

## Analysis

df <- merge(
  df,
  plot_labels[, c("term", "label")],
  by.x = "analysis",
  by.y = "term",
  all.x = TRUE
)

df <- dplyr::rename(df, "analysis_label" = "label")

df$analysis_label <- ifelse(
  grepl("main", df$analysis),
  "Main (maximally adjusted)",
  df$analysis_label
)

df$analysis_label <- ifelse(
  grepl("main-age_sex_adj", df$analysis),
  "Main (age- and sex- adjusted)",
  df$analysis_label
)

## Term

df <- merge(
  df,
  plot_labels[, c("term", "label")],
  by = "term",
  all.x = TRUE
)

df <- dplyr::rename(df, "term_label" = "label")

# Tidy estimate ----------------------------------------------------------------
print("Tidy estimate")

df$estimate <- ifelse(
  df$hr == "X",
  "X",
  paste0(
    display(as.numeric(df$hr)),
    " (",
    display(as.numeric(df$conf_low)),
    "-",
    display(as.numeric(df$conf_high)),
    ")"
  )
)

# Tidy term --------------------------------------------------------------------
print("Tidy term")

tmp <- plot_labels[
  plot_labels$label %in% df$term_label,
  c("label", "ref")
]

tmp <- tmp[order(tmp$ref), ]$label

df$time <- factor(
  df$term_label,
  levels = tmp
)

# Pivot table ------------------------------------------------------------------
print("Pivot table")

df <- df[, c(
  "analysis_label",
  "cohort",
  "outcome_label",
  "time",
  "estimate"
)]

df <- tidyr::pivot_wider(
  df,
  id_cols = c("analysis_label", "outcome_label", "time"),
  names_from = "cohort",
  values_from = "estimate"
)

# Order analyses ---------------------------------------------------------------
print("Order analyses")

tmp <- plot_labels[
  plot_labels$label %in% df$analysis_label,
  c("label", "ref_group")
]

tmp <- tmp[order(tmp$ref_group), ]$label

df$analysis_label <- factor(
  df$analysis_label,
  levels = c("Main (maximally adjusted)", "Main (age- and sex- adjusted)", tmp)
)

# Order outcomes ---------------------------------------------------------------
print("Order outcomes")

tmp <- plot_labels[
  plot_labels$label %in% df$outcome_label & !grepl("cov_", plot_labels$term),
  c("label", "ref")
]
tmp <- tmp[order(tmp$ref), ]$label

df$outcome_label <- factor(
  df$outcome_label,
  levels = c(
    "N",
    tmp
  )
)

# Tidy table -------------------------------------------------------------------
print("Tidy table")

df <- df[
  order(df$analysis_label, df$outcome_label, df$time),
  c(
    "analysis_label",
    "outcome_label",
    "time",
    "prevax",
    "vax",
    "unvax"
  )
]

df <- dplyr::rename(
  df,
  "Analysis" = "analysis_label",
  "Outcome" = "outcome_label",
  "Time since COVID-19" = "time",
  "Pre-vaccination cohort" = "prevax",
  "Vaccinated cohort" = "vax",
  "Unvaccinated cohort" = "unvax"
)

# Save table -------------------------------------------------------------------
print("Save table")

readr::write_csv(df, "output/post_release/table3.csv", na = "-")
