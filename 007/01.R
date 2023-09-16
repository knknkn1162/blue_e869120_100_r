options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

N <- readLines(conn, n=1) |> parse_number()
rot_cw <- c(0,-1,1,0) |> matrix(nrow=2)
rot_ccw <- c(0,-1,1,0) |> matrix(nrow=2)

tb <- read.table(conn, nrows=N) |>
  as_tibble() |>
  mutate(idx = row_number()) |>
  rename(x = V1, y = V2) |>
  rowwise() |>
  mutate(p = list(c(x,y))) |>
  select(idx,p)
coords <- tb |> pull(p)
# idx.v1 p.v1      idx.v2 p.v2      diff       area
ctb <- cross_join(tb,tb, suffix=c(".v1", ".v2")) |>
  filter(idx.v1 < idx.v2) |>
  mutate(diff = list(p.v2 - p.v1), area = sum(diff^2))
# detect v3,v4
## check cw
cw_max <- ctb |>
  mutate(p.v3 = list(p.v1 + (rot_cw %*% diff)), p.v4 = list(p.v3 + diff)) |>
  ungroup() |>
  filter(p.v3 %in% coords, p.v4 %in% coords ) |>
  summarize(max(area,0)) |>
  pull()
## check ccw
ccw_max <- ctb |>
  mutate(p.v3 = list(p.v1 + (rot_ccw %*% diff)), p.v4 = list(p.v3 + diff)) |>
  ungroup() |>
  filter(p.v3 %in% coords, p.v4 %in% coords ) |>
  summarize(max(area,0)) |>
  pull()

max(cw_max, ccw_max) |>
  cat()