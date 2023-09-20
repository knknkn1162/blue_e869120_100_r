options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

inputs <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()
N <- inputs[1]; M <- inputs[2]

tb <- read.table(conn, nrows = M) |>
  as_tibble() |>
  mutate(flag = TRUE)

1:(2^N-1) |>
  map(\(x) intToBits(x) |>
    as.logical() |>
    (\(y) (1:N)[y])()
  ) |>
  # detect completed map(vec) \supset tb
  map(\(vec) expand_grid(V1=vec,V2=vec) |>
    filter(V1 < V2) |>
    left_join(tb) |>
    replace_na(list(flag=FALSE)) |>
    pull(flag) |>
    all() |>
    (\(x) if_else(x, length(vec), 0))()
  ) |>
  unlist() |>
  max() |>
  cat()