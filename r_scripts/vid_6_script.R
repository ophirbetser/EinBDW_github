
?matrix


mat <- matrix(rnorm(20), 5, 4)
mat

mat[2, 3]
mat[2:3, 3:4]

dim(mat)
nrow(mat)
ncol(mat)

class(mat)
typeof(mat)
mode(mat)

mat2 <- matrix(as.character(mat), 5, 4)
class(mat2)
mode(mat2)


is.data.frame(warpbreaks)
class(warpbreaks)


is.matrix(as.matrix(1:10))
!is.matrix(warpbreaks)  # data.frame, NOT matrix!
warpbreaks[1:10,]
as.matrix(warpbreaks[1:10,])  # using as.matrix.data.frame(.) method

## Example of setting row and column names
mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3")))


mdat[1,]



dt <- warpbreaks

str(dt)
View(dt)

dt[1:6,]


dt[1:6, c("breaks", "wool")]
names(dt)

dt <- dt[dt$breaks < 50 & dt$wool == "A", c("breaks", "wool")]

dt[dt$breaks < 50, c("breaks", "wool")]

?data.frame

d$y
d$y_2 <- d$y + 8


L3 <- LETTERS[1:3]
fac <- sample(L3, 10, replace = TRUE)
d <- data.frame(hello = 1, y = 1:10, fac = fac)
## The "same" with automatic column names:
data.frame(1, 1:10, sample(L3, 10, replace = TRUE))

is.data.frame(d)

## do not convert to factor, using I() :
(dd <- cbind(d, char = I(letters[1:10])))
rbind(class = sapply(dd, class), mode = sapply(dd, mode))

stopifnot(1:10 == row.names(d))  # {coercion}

(d0  <- d[, FALSE])   # data frame with 0 columns and 10 rows
(d.0 <- d[FALSE, ])   # <0 rows> data frame  (3 named cols)
(d00 <- d0[FALSE, ])  # data frame with 0 columns and 0 rows




write.csv(dt, "/Users/ophirbetser/Ophir/R PROJECTS/EinBDW22/warpbreaks.csv")

dev.off()
cat("\014")
rm(list = ls()) 

dt <- read.csv("/Users/ophirbetser/Ophir/R PROJECTS/EinBDW22/warpbreaks.csv")

dt
