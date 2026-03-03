# Load libraries ----
print('Load libraries')

library(magrittr)

# Specify paths ----
print('Specify paths')

source("analysis/specify_paths.R")

# Load and prep plot labels ----
print('Load and prep plot labels')

plot_labels <- readr::read_csv("lib/plot_labels.csv")

plot_labels <- plot_labels[, c("term", "label", "ref")]

# Load and prep Table 1 ----
print('Load and prep Table 1')

table1 <- readr::read_csv(path_table1)

table1 <- table1[table1$Characteristic != "Age, years", ]

colnames(table1) <- gsub(
  " \\[midpoint6_derived\\]",
  "",
  gsub(" \\[midpoint6\\]", "", colnames(table1))
)

# Label characteristics ----
print('Label characteristics')

table1 <- merge(
  table1,
  plot_labels,
  by.x = "Characteristic",
  by.y = "term",
  all.x = TRUE
)

# Format table ----
print('Format table')

table1$Characteristic <- NULL
table1 <- dplyr::rename(table1, "Characteristic" = "label")

table1$`N (%)_prevax` <- ifelse(
  table1$Characteristic == "All",
  table1$N_prevax,
  paste0(table1$N_prevax, " ", table1$`(%)_prevax`)
)

table1$`N (%)_vax` <- ifelse(
  table1$Characteristic == "All",
  table1$N_vax,
  paste0(table1$N_vax, " ", table1$`(%)_vax`)
)

table1$`N (%)_unvax` <- ifelse(
  table1$Characteristic == "All",
  table1$N_unvax,
  paste0(table1$N_unvax, " ", table1$`(%)_unvax`)
)

table1 <- table1[
  order(table1$ref),
  c(
    "Characteristic",
    "Subcharacteristic",
    paste0(c("N (%)", "COVID-19 diagnoses"), "_prevax"),
    paste0(c("N (%)", "COVID-19 diagnoses"), "_vax"),
    paste0(c("N (%)", "COVID-19 diagnoses"), "_unvax")
  )
]

table1$Subcharacteristic <- ifelse(
  table1$Subcharacteristic == "TRUE",
  "",
  table1$Subcharacteristic
)

# Save tables ----

data.table::fwrite(
  table1[c(1:35), ],
  "output/post_release/table1.csv",
  row.names = FALSE
)

data.table::fwrite(
  table1[
    c(1, 36:55),
    c(
      "Characteristic",
      paste0(c("N (%)", "COVID-19 diagnoses"), "_prevax"),
      paste0(c("N (%)", "COVID-19 diagnoses"), "_vax"),
      paste0(c("N (%)", "COVID-19 diagnoses"), "_unvax")
    )
  ],
  "output/post_release/table1_extn.csv",
  row.names = FALSE
)
