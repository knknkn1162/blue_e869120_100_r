options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

S <- readLines(conn, n=1)

S |>
  str_extract_all("[AGTC]+") |>
  unlist() |>
  str_length() |>
  (\(x) max(x,0))() |>
  cat()