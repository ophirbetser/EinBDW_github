# openxlsx

# link
# https://ycphs.github.io/openxlsx/index.html

#load:
pacman::p_load(
  openxlsx,
  here,
  ggplot2
)

# example
wb <- createWorkbook()

addWorksheet(wb = wb, sheetName = "sheet_a")
writeData(wb = wb, sheet = "sheet_a", x = iris)

addWorksheet(wb = wb, sheetName = "sheet_b")
writeData(wb = wb, sheet = "sheet_b", x = mtcars, xy = c("B", 2))

addWorksheet(wb = wb, sheetName = "sheet_c")
writeData(wb = wb, sheet = "sheet_c", x = datasets::WorldPhones)
ggplot(iris) + aes(Sepal.Length,Sepal.Width) + geom_point()
insertPlot(wb, sheet = "sheet_c", xy = c("E", 2))

openXL(wb) ## view without saving
saveWorkbook(wb, here("datasets", "openxlsx_e1.xlsx"), overwrite = TRUE) # save

