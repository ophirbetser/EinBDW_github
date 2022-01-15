
# לולאות
for (i in 30:40){
  print(i)
}


for (i in c(1,9,9,6)){
  print(i)
}

for (i in letters){
  print(i)
}


for (num in 30:40){
  num_s <- num**2
  num_s <- num_s + 5
  print(num_s)
}

res <- 0

for (num in 30:40){
  res <- res + num
}

print(res)

res <- vector()

for (num in 30:40){
  res <- c(res, num %% 2 == 0)
}

print(res)

# תנאים

class(F)
value <- TRUE

if (class(value) == "numeric"){
  print(value ** 2)
} else{
  print("not numeric")
}

if (class(value) == "numeric"){
  print(value ** 2)
} else if (class(value) == "logical"){
  print(value)
} else {
  print("not numeric & not logical")
}



# שילוב

for (i in 30:40){
  if(i %% 2 == 0){
    print(i /2)
  } else{
    print((i + 1) / 2)
  }
}

v <- (30:40) %% 2 == 0
ifelse(v == TRUE, 1, 0)

?ifelse

v <- (30:40)
ifelse(v %% 2 == 0, v, 0)
