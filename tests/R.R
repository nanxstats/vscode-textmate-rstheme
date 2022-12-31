library("ggsci")
library("ggplot2")
library("gridExtra")

data("diamonds")

p <- ggplot(
  subset(diamonds, carat > 2.2 & depth > 55 & depth < 70),
  aes(x = depth, fill = cut)
) +
  geom_histogram(colour = "#333333", binwidth = 1, position = "dodge") +
  theme_bw()

p + scale_fill_rickandmorty()
