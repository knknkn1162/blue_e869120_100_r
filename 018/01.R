options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

N <- readLines(conn, n=1) |> parse_number()
S <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()

q <- readLines(conn, n=1) |> parse_number()
Ts <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()

res <- c()
for(i in 1:q) {
  item <- Ts[i]
  res[i] <- gtools::binsearch(\(x) 
    if_else(
      x > item,
      1,
      if_else(x < item, -1, 0)
    ),
    range = S
  )$value
}

(res == 0) |>
  sum() |>
  cat()
