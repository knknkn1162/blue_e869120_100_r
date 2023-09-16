options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

N <- readLines(conn, n=1) |> parse_number()
inputs <- readLines(conn, n=1)

1:999 |>
  as.character() |>
  str_pad(width=3,pad="0") |>
  # create regex
  map(\(s) str_c(s |> str_split_1("") |> str_flatten(".*"))) |>
  unlist() |>
  (\(x) str_detect(inputs, x))() |>
  sum() |>
  cat()
  