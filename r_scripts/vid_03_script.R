
# שימוש ב ר בתור מחשבון

4 + 5
4 - 5
4 * 5
4 ** 5
4^5
9 / 4
9 %/% 4
abs(-7)
sqrt(9)
9**0.5

# יצירה של וקטורים ב ר
x <- c(1, 2, 3, 4)
class(x)

x_char <- c("1", "2", "3", 4)
class(x_char)
"1" + "5"

5:18
?seq
seq(5, 18, 0.5)

rep(1, 100)
rep(c(1,2,3), 5)
?rep
rep(c(1,2,3), each = 5)

# משתנים של אמת ושקר
TRUE
FALSE
class(TRUE)
TRUE + FALSE

my_vector <- 3:23

my_vector[my_vector > 10]
my_vector[my_vector >= 10]
my_vector[my_vector == 10]

my_vector[c(3, 6, 9)]

my_vector[my_vector %in% c(3,7,56,3,2,34)]

# פונקציות סטטיסטיות
sum(my_vector)
mean(my_vector)
var(my_vector)
sd(my_vector)
var(my_vector)**0.5

sum((my_vector - mean(my_vector))**2) / (length(my_vector) - 1)

exp(c(2,5,8))
median(seq(6, 100, 0.7))

my_rnorm_v <- rnorm(10)
min(my_rnorm_v)
max(my_rnorm_v)
sort(my_rnorm_v)

my_rnorm_v <- sort(my_rnorm_v)

my_rnorm_v1 <- rnorm(10) # מגריל 10 מספרים מתוך ההתפלגות הנורמלית
my_rnorm_v2 <- rnorm(10)

cor(my_rnorm_v1, my_rnorm_v2)
cov(my_rnorm_v1, my_rnorm_v2)

my_rnorm_v1
round(my_rnorm_v1, 3)

quantile(my_rnorm_v1)
quantile(my_rnorm_v1, c(0.1, 0.9))

summary(my_rnorm_v1)

# ערכים חסרים
a <- c(1,3,6,3, NA, 4, NA)
is.na(a)
a[is.na(a) != T]

mean(a)
mean(a, na.rm = T)

