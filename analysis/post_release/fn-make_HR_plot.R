make_HR_plot <- function(
  outcomes = c("ate", "vte"),
  analysis_groups = c("main"),
  main_hosp = TRUE,
  hr_low = 0.5,
  hr_high = 128,
  facet_rows = 2,
  facet_cols = 3,
  legend_vertical = FALSE
) {
  # Load model output ----

  df <- data.table::fread("output/post_release/model_output.csv")

  # Load plot labels ----

  plot_labels <- data.table::fread("lib/plot_labels.csv")

  # Filter model output ----

  unique_terms <- unique(df$term)

  days_terms <- setdiff(
    unique_terms[grep("days", unique_terms, ignore.case = TRUE)],
    c("days_pre", "days0_1")
  )

  df <- df[
    df$term %in%
      days_terms &
      df$outcome %in% outcomes &
      !is.na(df$outcome_time_median) &
      df$model == "mdl_max_adj",
  ]

  if (isFALSE(main_hosp)) {
    df <- df[df$analysis == "main", ]
  } else {
    df <- df[
      df$analysis %in%
        plot_labels[plot_labels$analysis_group %in% analysis_groups, ]$term,
    ]
  }

  # Label outcomes ----

  outcome_labels <- plot_labels[
    plot_labels$term %in% outcomes,
    c("term", "label", "ref")
  ]

  outcome_labels <- dplyr::rename(
    outcome_labels,
    "outcome" = "term",
    "outcome_disp" = "label",
    "outcome_ref" = "ref"
  )

  df <- merge(
    df,
    outcome_labels,
    by = "outcome"
  )

  # Label analyses ----

  analysis_labels <- plot_labels[
    plot_labels$analysis_group %in% analysis_groups,
    c("term", "label", "ref")
  ]

  analysis_labels <- dplyr::rename(
    analysis_labels,
    "analysis" = "term",
    "analysis_disp" = "label",
    "analysis_ref" = "ref"
  )

  df <- merge(
    df,
    analysis_labels,
    by = "analysis"
  )

  # Force all outcomes and analyses to plot ----

  tmp <- tidyr::crossing(analysis_labels, outcome_labels)
  tmp$hr <- -1
  tmp$outcome_time_median <- -1
  df <- plyr::rbind.fill(df, tmp)

  # Order outcomes and analyses ----

  df$outcome_disp <- factor(
    df$outcome_disp,
    levels = outcome_labels$outcome_disp[order(outcome_labels$outcome_ref)]
  )

  df$analysis_disp <- factor(
    df$analysis_disp,
    levels = analysis_labels$analysis_disp[order(analysis_labels$analysis_ref)]
  )

  # Calculate maximum value for x axis

  max_time <- max(df$outcome_time_median)

  # Make base plot ----

  p <- ggplot2::ggplot(
    data = df,
    mapping = ggplot2::aes(x = outcome_time_median, y = hr, color = cohort)
  ) +
    ggplot2::geom_hline(
      mapping = ggplot2::aes(yintercept = 1),
      colour = "#A9A9A9"
    ) +
    ggplot2::geom_point(position = ggplot2::position_dodge(width = 0)) +
    ggplot2::geom_errorbar(
      mapping = ggplot2::aes(ymin = conf_low, ymax = conf_high, width = 0),
      position = ggplot2::position_dodge(width = 0)
    ) +
    ggplot2::geom_line(position = ggplot2::position_dodge(width = 0)) +
    ggplot2::scale_y_continuous(
      lim = c(hr_low, hr_high),
      breaks = 2^seq(-100, 100),
      trans = "log"
    ) +
    ggplot2::scale_x_continuous(
      breaks = seq(0, max_time, (365 / 2)),
      labels = seq(0, max_time, (365 / 2)) / 365
    ) +
    ggplot2::scale_color_manual(
      breaks = c("prevax", "vax", "unvax"),
      labels = c(
        "Pre-vaccine availability (Jan 1 2020 - May 31 2025)",
        "Vaccinated (Jun 1 2021 - May 31 2025)",
        "Unvaccinated (Jun 1 2021 - May 31 2025)"
      ),
      values = c("#d2ac47", "#58764c", "#0018a8")
    ) +
    ggplot2::labs(
      x = "\nYears since COVID-19 diagnosis",
      y = "Hazard ratio and 95% confidence interval\n"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.spacing.x = ggplot2::unit(0.5, "lines"),
      panel.spacing.y = ggplot2::unit(0, "lines"),
      strip.text = ggplot2::element_text(hjust = 0, vjust = 0),
      legend.key = ggplot2::element_rect(colour = NA, fill = NA),
      legend.title = ggplot2::element_blank(),
      legend.position = "bottom",
      plot.background = ggplot2::element_rect(fill = "white", colour = "white")
    )

  # Handle single analysis plots ----

  if (length(unique(df$analysis)) == 1) {
    p <- p +
      ggh4x::facet_wrap2(
        ~outcome_disp,
        strip = ggh4x::strip_nested(),
        nrow = facet_rows,
        ncol = facet_cols
      )
  } else {
    p <- p +
      ggh4x::facet_wrap2(
        ~ outcome_disp + analysis_disp,
        strip = ggh4x::strip_nested(),
        nrow = facet_rows,
        ncol = facet_cols
      )
  }

  # Make legend vertical or horizontal as requested ----

  if (isTRUE(legend_vertical)) {
    p <- p + ggplot2::guides(color = ggplot2::guide_legend(ncol = 1))
  } else {
    p <- p + ggplot2::guides(color = ggplot2::guide_legend(nrow = 1))
  }

  # Return plot object p ----

  return(p)
}
