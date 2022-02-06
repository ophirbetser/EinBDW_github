pacman::p_load(
  glue,
  here,
  tidyverse
)

?list.files()

list.files()
list.files(pattern = ".csv")
list.files(recursive = T)

?assign
assign("x", 5)
assign("y", 3)

?glue
glue("this_is_x={x}_and this is y = {y}")

?get
get("x")
x == get("x")

for(file_name in list.files(pattern = ".csv", recursive = T)){
  assign(
    str_remove(file_name, ".csv"),
    fread(file_name)
  )
}

list.files()
list.files(here("datasets"))

fread(here("datasets", "Cohort.csv"))

