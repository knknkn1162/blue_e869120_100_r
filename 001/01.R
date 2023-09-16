options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

inputs = c()
for(i in 1:10) {
  item = readLines(conn, n=1)
  if(item == "0 0") {
    break;
  }
  inputs[i] = item
}
inputs <- inputs |> str_split_1(" ") |> parse_number()
N <- inputs[1]; X <- inputs[2]

expand_grid(a=1:N,b=1:N) |>
  data.frame() |>
  as_tibble() |>
  filter(a<b) |>
  mutate(c = X-a-b) |>
  filter(b < c, c <= N) |>
  nrow() |>
  cat()