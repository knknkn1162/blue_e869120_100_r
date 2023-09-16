options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

inputs <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()
N <- inputs[1]; M <- inputs[2]

A <- read.table(conn) |>
  as_tibble()

expand_grid(T1 = 1:M, T2 = 1:M) |>
  filter(T1 < T2) |>
  rowwise() |>
  group_map(\(sdf,key) A |>
    select(sdf |> unlist()) |>
    rowwise() |>
    mutate(v = max(c_across(everything()))) |>
    ungroup() |>
    # TODO: use bigint
    summarize(sum(v)) |>
    pull()
  ) |>
  unlist() |>
  max() |>
  cat()