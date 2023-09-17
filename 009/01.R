options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

M <- readLines(conn, n=1) |> parse_number()
mtb <- read.table(conn, nrows=M) |>
  as_tibble()
N <- readLines(conn, n=1) |> parse_number()
ntb <- read.table(conn, nrows=N) |>
  as_tibble() |>
  rename(X1 = V1, X2 = V2)

ntb |>
  rowwise() |>
  group_map(\(tb,key) mtb |>
    mutate(diff.1 = tb$X1-(mtb |> first() |> pull(V1)), diff.2 = tb$X2-(mtb |> first() |> pull(V2))) |>
    mutate(X1 = V1 + diff.1, X2 = V2 + diff.2) |> 
    inner_join(ntb) |>
    summarize(n = n(), diff.1 = first(diff.1), diff.2 = first(diff.2))
  ) |>
  list_rbind() |>
  filter(n == M) |>
  (\(x) cat(c(x$diff.1, x$diff.2)))()