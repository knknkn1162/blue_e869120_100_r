# slider
options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

N <- readLines(conn, n=1) |> parse_number()
A <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()

  
for(k in 1:N) {
  A |>
    as_tibble() |>
    slide(\(tb) tb |> summarize(sum(value)) |> pull(), .before=(k-1), .complete = TRUE) |>
    unlist() |>
    max() |>
    cat(sep="\n")
}
