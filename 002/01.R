options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

N <- readLines(conn, n=1) |> parse_number()

1:N |>
  as_tibble() |>
  filter(value %% 2 == 1) |>
  rowwise() |>
  mutate(v = sum(value %% 1:value == 0)) |>
  filter(v == 8) |>
  nrow() |>
  cat()