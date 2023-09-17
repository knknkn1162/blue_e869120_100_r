options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

N <- readLines(conn, n=1) |> parse_number()
A <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()
Q <- readLines(conn, n=1) |> parse_number()
M <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()

table <- 1:(2^N-1) |>
  map(\(x) ((!!bitwAnd(2^(0:(N-1)),x)) * A) |> sum()) |>
  unlist() |>
  sort() |>
  unique()

M %in% table |>
  (\(x) if_else(x, "yes", "no"))() |>
  cat(sep="\n")