

# A
# 1
x <- 5
y <- 3

z <- x
x <- y
y <- z

# 2
x <- 80
y <- 10

x*0.25 + y *0.75 >= 51 

# 3
1:10
9:1
c(1:10, 9:1)

# 4
x <- sample(1:100, 10)
y <- sample(80:180, 10)

min(y) > max(x)

# 5
length(x)
x[length(x)]

# 6
x <- sample(1:100, 25)
x[seq(2, length(x), 2)]

# 7
x <- c(1,6,3,2,3,5,3, NaN, 4,7,6,4, NaN, 4)

x[!is.nan(x)]

# 8
x <- sample(1:100, 25)
sum(x %% 3 == 0)

# 9
x <- sample(1:100, 25)

prod(x)**(1/length(x))

# 10
x <- sample(1:100, 25)

length(x) / sum((1 / x))

# 11
x <- sample(1:100, 25)
x[x == min(x)] <- 17

# 12
n <- 5
m <- 10

matrix(rep(1:5, 10), n, m)

# 13
mat <- matrix(rep(1:5, 10), n, m)

nrow(mat) > ncol(mat)

# 14
mat_pos <- matrix(sample(1:100, 50), n, m)
mat_not_only_pos <- matrix(sample(-100:100, 50), n, m)

all(mat_pos > 0)
all(mat_not_only_pos > 0)

# 15
mat_pos[nrow(mat_pos) - 1, ]

# 16
mat_pos
mat_pos[nrow(mat_pos):1,]

# 17
res <- 0
for(col in 1:ncol(mat_pos)){
  res <- res + max(mat_pos[, col])
}

sum(apply(mat_pos, 2, max))

# 18
which.max(apply(mat_pos, 2, max))

# 19
mat <- matrix(0, 5, 5)
for(i in 1:5){
  mat[i,i] <- 17
}

# 20
n <- 10

mat <- matrix(1, n, n)
mat[2:(nrow(mat)-1), 2:(ncol(mat)-1)] <- 0


# B
# 1
f1 <- function(mat){
  which.max(apply(mat, 2, sum))
}

r_mat <- matrix(rnorm(25), 5, 5)
f1(r_mat)

# 2
f2 <- function(v){
  all(v == v[1])
}

f2(rep(1:2, 10))

# 3
f3 <- function(v1, v2){
  if(length(v1) == length(v2)){
    if(all(v1 == v2)){
      return(TRUE)
    }
    return(FALSE)
  }
  return(FALSE)
}

f3(rep(1:2, 5), rep(c(1, 3), 5))

# 4
f4 <- function(v){
  corent_max <- v[1]
  for(val in v){
    if(val > corent_max){
      corent_max <- val
    }
  }
  return(corent_max)
}

# 5
n <- 4
mat <- matrix(0, n, n)
for(i in 1:n){
  mat[i,ncol(mat) - i + 1] <- 1
}

f5 <- function(n){
  diag(n)[n:1,]
}

f5(8)

# 6

f6 <- function(v){
  if(length(v) == 1){
    return(v[1])
  }
  v[length(v)-1] <- v[length(v)-1] + v[length(v)]
  return(f6(v[1:(length(v)-1)]))
}

f6(1:4)

# 7
fibonacci <- function(n){
  if(n %in% 1:2){
    return(1)
  }
  before <- 1
  corent <- 1
  for(i in 3:n){
    now <- corent + before
    before <- corent
    corent <- now
  }
  return(now)
}

# 8
f <- function(mat){
  mat[2:(nrow(mat)-1), 2:(ncol(mat)-1)] <- 0
  return(mat)
}
  
f(matrix(rnorm(100), 10, 10))  
