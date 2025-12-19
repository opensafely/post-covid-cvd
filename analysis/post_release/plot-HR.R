# Define plot features ----
print('Define plot features')

plot_info <- data.frame(
  name = character(),
  outcomes = character(),
  analysis = character(),
  facet_rows = numeric(),
  facet_cols = numeric(),
  plot_height = numeric(),
  plot_width = numeric(),
  legend_vertical = logical()
)

plot_info[nrow(plot_info) + 1, ] <- c(
  "main-ATE",
  "ate;ami;stroke_isch",
  "main",
  3,
  3,
  210,
  297,
  FALSE
)
plot_info[nrow(plot_info) + 1, ] <- c(
  "main-VTE",
  "vte;pe;dvt",
  "main",
  3,
  3,
  210,
  297,
  FALSE
)
plot_info[nrow(plot_info) + 1, ] <- c(
  "main-OtherCVD",
  "hf;angina;tia;stroke_sahhs",
  "main",
  4,
  3,
  210,
  297,
  FALSE
)
plot_info[nrow(plot_info) + 1, ] <- c(
  "sub_covidhistory",
  "ate;vte",
  "covidhistory",
  2,
  1,
  210,
  130,
  TRUE
)
plot_info[nrow(plot_info) + 1, ] <- c(
  "sub_sex",
  "ate;vte",
  "sex",
  2,
  2,
  210,
  210,
  TRUE
)
plot_info[nrow(plot_info) + 1, ] <- c(
  "sub_ethnicity",
  "ate;vte",
  "ethnicity",
  2,
  5,
  210,
  297,
  FALSE
)
plot_info[nrow(plot_info) + 1, ] <- c(
  "sub_age",
  "ate;vte",
  "age",
  2,
  4,
  210,
  297,
  FALSE
)
plot_info[nrow(plot_info) + 1, ] <- c(
  "sub_ate",
  "ate",
  "ate",
  2,
  2,
  110,
  210,
  TRUE
)
plot_info[nrow(plot_info) + 1, ] <- c(
  "sub_vte",
  "vte",
  "vte",
  2,
  2,
  110,
  210,
  TRUE
)

plot_info <- plot_info %>%
  dplyr::mutate(dplyr::across(
    c(facet_rows, facet_cols, plot_height, plot_width),
    as.numeric
  ))

plot_info$legend_vertical <- as.logical(plot_info$legend_vertical)

# Make plots ----
print('Make plots')

for (i in 1:nrow(plot_info)) {
  message(paste0(
    "Making plot: ",
    plot_info[i, "analysis"],
    " - ",
    plot_info[i, "outcomes"]
  ))

  p <- make_HR_plot(
    outcomes = strsplit(plot_info[i, "outcomes"], ";")[[1]],
    analysis_groups = plot_info[i, "analysis"],
    main_hosp = TRUE, # Set to false if you want the main analyses without COVID-19 severity incorporated
    hr_low = 0.5,
    hr_high = 96,
    facet_rows = plot_info[i, "facet_rows"],
    facet_cols = plot_info[i, "facet_cols"],
    alpha = 0.5,
    legend_vertical = plot_info[i, "legend_vertical"]
  )

  ggplot2::ggsave(
    paste0("output/post_release/", plot_info[i, "name"], ".png"),
    p,
    height = plot_info[i, "plot_height"],
    width = plot_info[i, "plot_width"],
    unit = "mm",
    dpi = 600,
    scale = 0.8
  )
}
