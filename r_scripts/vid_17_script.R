pacman::p_load(
  ggplot2,
  esquisse,
  ggthemes
)

my_plot <- 
  ggplot(iris) +
  aes(y = Sepal.Length, x = Species, color = Species) +
  geom_boxplot(fill = "#B984E1")

my_plot
my_plot + theme_base()
my_plot + theme_bw()
my_plot + theme_classic()
my_plot + theme_void()
my_plot + theme_dark()
my_plot + ggthemes::theme_stata()
my_plot + ggthemes::theme_excel()
my_plot + ggthemes::theme_excel_new()
my_plot + ggthemes::theme_excel_new()
my_plot + ggthemes::theme_economist()


