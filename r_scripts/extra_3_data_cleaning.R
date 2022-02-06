


names(dt) <- 
  str_replace(
  str_to_lower(names(dt)),
  "\\.", "_"
  )


dt <- dt[sepal_length > 4.5]
