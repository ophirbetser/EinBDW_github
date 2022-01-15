

high_cor <- function(x, y){
  corr <- cor(x, y)
  if(abs(corr) > 0.5){
    return(1)
  } else{
    return(0)
  }
}

x <- seq(1, 100)
y <- seq(101, 200)

high_cor(x, y)

x <- seq(1, 100)
y <- seq(100, 200)

high_cor(x, y)

high_cor_better <- function(x, y){
  if(length(x) != length(y)){
    print("bad input! not same length")
    return(NULL)
  }
  
  corr <- cor(x, y)
  if(abs(corr) > 0.5){
    return(1)
  } else{
    return(0)
  }
}

v_1 <- seq(1, 100)
v_2 <- seq(101, 200)

high_cor_better(v_1, v_2)
high_cor_better(x = v_1, y = v_2)
res <- high_cor_better(y = v_1, x = v_2)
