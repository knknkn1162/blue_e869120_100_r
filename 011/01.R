options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

inputs <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()
N <- inputs[1]; M <- inputs[2]

ks <- readLines(conn, n=M)

p <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()

switch_tb <- ks |>
  str_split(" ") |>
  map(\(x) parse_number(x)) |>
  matrix() |>
  as_tibble() |>
  rowwise() |>
  mutate(V1 = list(V1[-1])) |>
  ungroup() |>
  mutate(p = p)

1:(2^N-1) |>
  map(\(x) intToBits(x) |>
        as.logical() |>
        (\(y) (1:N)[y])()
  ) |>
  map(\(vec) switch_tb |>
        rowwise() |>
        mutate(n = sum(vec %in% V1) %% 2) |>
        filter(p == n) |>
        nrow() == M
  ) |>
  unlist() |>
  sum() |>
  cat()
  