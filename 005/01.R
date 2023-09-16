options(scipen=100)
#conn <- file("stdin", open="r")
conn <- stdin()

inputs <- readLines(conn, n=1) |> str_split_1(" ") |> parse_number()
A <- inputs[1]; B <- inputs[2]; C <- inputs[3]; X <- inputs[4]; Y <- inputs[5]
AB <- A + B
num <- if_else(X > Y, (X-Y)*A, (Y-X)*B)
num <- num + min(X,Y) * min(A+B, C*2)
num <- min(num,  max(X,Y) * C * 2)
cat(num)