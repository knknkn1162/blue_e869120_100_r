# slider
options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

N <- readLines(conn, n=1) |> parse_number()
A <- readLines(conn, n=N) |> parse_number()

lst <- A |>
  as_tibble() |>
  mutate(n = 1, idx = rowwise()) |>
  rowwise() |>
  group_split()

for(item in lst) {
  # print(item)
}

# c(lst[1],lst[2]) |> list_rbind() |> summarize(n = sum(n), value = last(value))
# lst |> reduce(\(acc,nxt) {
#   if_else()
#   list(acc,nxt) |> list_rbind() |> summarize(n = sum(n), value = last(value))
# } )