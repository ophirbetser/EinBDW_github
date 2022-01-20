# class_problems
## link to questions:

## https://github.com/ophirbetser/EinBDW_github/blob/master/else/class_problems.pdf

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

# C

# 1
count.char <- function(st, ch){
  sum(strsplit(st, "")[[1]] == rep(ch, nchar(st)))
}

# 2
f <- function(st){
  sum(!strsplit(st, "")[[1]] %in% c(letters, LETTERS))
}

# 3
for(num in c(3, 5, 1, 2)){
  print(paste0(rep("*", num), collapse = ""))
}

# 4
print.sum <- function(num_v){
  print(
    paste0(paste0(num_v, collapse = " + "), " = ", sum(num_v))
  )
}

# 5
n <- 10
for(i in 1:n){
  write(
    paste0(rep("*", i), collapse = ""),
    file = paste0("junk/ophir", i, ".txt")
    )
}

# 6
f <- function(s, ch){
  if(ch %in% strsplit(s, "")[[1]]){
    return(which.max((strsplit(s, "")[[1]] == ch)))
  } else{
    return(0)
  }
}


# D

# 1
pacman::p_load(
  matlab
)
a <- 1
b <- 1000

for(i in seq(a, b-2, 1)){
  if(isprime(i) & isprime(i+2)){
    print(paste0(i, " , ", i+2))
  }
}

# 2
perfect.number <- function(n){
  sum <- 0
  for(i in 1:(n-1)){
    if(n %% i == 0){
      sum <- sum + i
    }
  }
  return(sum == n)
}

perfect.number(8128)

# 3
digit.sum <- function(num){
  if(num < 10){
    return(num)
  }
  return(
    digit.sum(
      sum(as.numeric(strsplit(as.character(num), "")[[1]]))
    )
  )
}

# 4



# 5

right_id <- function(st){
  if(nchar(st) != 8){
    return(
    paste0(
      paste0(rep("0", 8 - nchar(st)), collapse = ""),
      st
    )
    )
  } else{
    return(st)
  }
}

find.check.digit <- function(id){
  res1 <- as.numeric(strsplit(right_id(as.character(id)), "")[[1]]) * rep(1:2, 4)
  res2 <-paste0(as.character(res1), collapse = "")
  return(10 - (sum(as.numeric(strsplit(res2, "")[[1]])) %% 10) %% 10)
  
}

verify.check.digit <- function(id){
  last_ch <- 
    substr(as.character(id), nchar(as.character(id)), nchar(as.character(id)))
  without_last_ch <- 
    substr(as.character(id), 1, nchar(as.character(id)) - 1)
  
  return(find.check.digit(without_last_ch) == as.numeric(last_ch))
}
  
