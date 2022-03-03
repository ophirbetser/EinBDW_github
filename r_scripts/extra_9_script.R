#### stargazer:
# data
data_example <- wooldridge::bwght 

data_example %>% View()

# Reg Model 1:

model_1_example <- lm(bwght ~ cigs + faminc + motheduc + factor(male), data_example)

# Reg Model 2:

model_2_example <- lm(lbwght ~ cigs + faminc + motheduc + factor(male), data_example)

# Results Table:
stargazer(
  model_1_example,
  model_2_example,
  type = 'html',
  omit = c('male'),
  #column.labels = '',
  covariate.labels = c(
    'cigs smked per day while preg',
    "mother's yrs of educ",
    '1988 family income' 
  ),
  dep.var.labels =  c('Birth weight ', 'Log of Birth weight'),
  add.lines = list(
    c(
      'Gender FE',
      'X',
      'X'
    )
  ),
  title="The Effect of Smoking on Child's Weight", align=TRUE, omit.stat=c("f"),order=c("cigs", "motheduc"),
  out = 'stargazer_example.html'
)

