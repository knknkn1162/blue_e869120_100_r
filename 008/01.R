options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

N <- readLines(conn, n=1) |> parse_number()

tb <-
  read.table(conn, nrows=N) |>
  as_tibble()

vec <- tb |>
  unlist() |>
  sort()

# TODO: support 64bit
expand_grid(a=vec,b=vec) |>
  rowwise() |>
  group_map(\(stb,key)
    tb |>
      rowwise() |>
      mutate(dist = abs(V1-stb$a)+(V2-V1)+abs(V2-stb$b)) |>
      ungroup() |>
      summarize(sum = sum(dist)) |>
      pull(sum)
  ) |>
  unlist() |>
  min() |>
  cat()