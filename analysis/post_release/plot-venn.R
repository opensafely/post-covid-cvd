library(svglite)
library(VennDiagram)
library(grid)
library(gridExtra)

# Create directory -------------------------------------------------------------
print("Create directory")

fs::dir_create(here::here("output/post_release/", "venn"))

# Load data --------------------------------------------------------------------
print("Load data")

df <- readr::read_csv(path_venn, show_col_types = FALSE)
colnames(df) <- gsub("_midpoint6", "", colnames(df))

# Add extra info ---------------------------------------------------------------
print("Add extra info")

df$outcome <- gsub(".*-", "", df$name)
df$total_gp <- df$only_gp + df$gp_apc + df$gp_death + df$gp_apc_death
df$total_apc <- df$only_apc + df$gp_apc + df$apc_death + df$gp_apc_death
df$total_death <- df$only_death + df$gp_death + df$apc_death + df$gp_apc_death

# Create Venn for each outcome/cohort combo ------------------------------------
print("Create Venn for each outcome/cohort combo")

for (i in 1:nrow(df)) {
  paste0("Outcome: ", df[i, ]$outcome, "; Cohort: ", df[i, ]$cohort)

  venn.plot <- VennDiagram::draw.triple.venn(
    area1 = df[i, ]$total_gp,
    area2 = df[i, ]$total_apc,
    area3 = df[i, ]$total_death,
    n12 = df[i, ]$gp_apc + df[i, ]$gp_apc_death,
    n23 = df[i, ]$apc_death + df[i, ]$gp_apc_death,
    n13 = df[i, ]$gp_death + df[i, ]$gp_apc_death,
    n123 = df[i, ]$gp_apc_death,
    category = c("Primary care", "Secondary care", "Death registry"),
    col = "white",
    fill = c("#1b9e77", "#d95f02", "#7570b3"),
    print.mode = c("raw", "percent"),
    sigdigs = 3
  )

  grid.draw(venn.plot)
  grid.newpage()
  tiff(
    paste0(
      "output/post_release/venn/venn-",
      df[i, ]$cohort,
      "-",
      df[i, ]$outcome,
      ".tiff"
    ),
    compression = "lzw"
  )
  grid.draw(venn.plot)
  dev.off()
}
