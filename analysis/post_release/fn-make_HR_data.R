make_hr_data <- function(model_output) {
  # Make master ----
  print('Make master')

  df <- NULL

  for (file in model_output) {
    # Load model output file ----
    print('Load model output file')

    tmp <- readr::read_csv(file, show_col_types = FALSE) %>%
      dplyr::mutate(source_file = gsub(".*release/", "", file))

    if (!(grepl("-main-", file) | grepl("-sub_covidhospital-", file))) {
      # Restrict outcomes ----
      print('Restrict outcomes')
      tmp <- tmp[tmp$outcome %in% c("ate", "vte"), ]
    }

    # Bind to master ----
    print('Bind to master')

    df <- dplyr::bind_rows(df, tmp)
  }

  # Write out complete model output ----
  print('Write out complete model output')

  readr::write_csv(
    df,
    "output/post_release/model_output.csv"
  )
}
