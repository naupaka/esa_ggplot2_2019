# Sample code for ggplot2 workshop at ESA 2019
# Naupaka Zimmerman
# August 11, 2019
# nzimmerman@usfca.edu

# load libraries
library("ggplot2")
library("tidyr")
library("dplyr")
library("ggthemes")

# iris is wide data
head(iris)

# convert wide data to long data
long_iris <- gather(iris,
                    key = flower_attribute,
                    value = measurement,
                    -Species)

# our first ggplot! Saved to an object
myplot <- ggplot(data = iris,
                 aes(x = Sepal.Length,
                     y = Sepal.Width))

# display the plot object
myplot

# what's under the hood
summary(myplot)

# add a geom
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width)) +
  geom_point()

# setting size
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width)) +
  geom_point(size = 3)

# setting size and mapping color
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point(size = 3)

# setting size and mapping color and shape
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species,
           shape = Species)) +
  geom_point(size = 3)

# setting size and mapping color and shape
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point(size = 3,
             aes(shape = Species))

# diamonds plot -- challenge 1
View(diamonds)

ggplot(data = diamonds,
       aes(x = carat,
           y = price,
           color = color)) +
  geom_point()

# need to load this library for the borthweight dataset
library("MASS")
View(birthwt)

# convert numeric column to factor for boxplot
myboxplot <- ggplot(data = birthwt,
                    aes(x = factor(race),
                        y = bwt)) +
  geom_boxplot()

# peek under the hood
summary(myboxplot)

# FACETS!!!
ggplot(iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point() +
  facet_grid(Species ~ .)

# FACETS!!!
ggplot(iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point() +
  facet_wrap(~ Species)

# change color
ggplot(iris,
      aes(x = Sepal.Width,
          y = Sepal.Length,
          color = Species)) +
  geom_point(color = "dodgerblue")

# custom colors
my_point_colors <- c("blue", # setosa
                     "purple", # versicolor
                     "orange") #virginica

# using a custom palatte
ggplot(iris,
       aes(x = Sepal.Width,
           y = Sepal.Length,
           color = Species)) +
  geom_point() +
  scale_color_manual(values = my_point_colors)

# some alternative, professionally chosen palettes of colors
# install.packages("RColorBrewer") # only need to install once
library("RColorBrewer")

# show the palettes
display.brewer.all()

# adjust a continuous scale
ggplot(birthwt,
       aes(x = factor(race),
           y = bwt)) +
  geom_boxplot(width = 0.5) +
  scale_y_continuous(labels = paste0(1:5, " kg"),
                     breaks = seq(1000, 5000, by = 1000))

# check out the Old Faithful dataset
View(faithful)

# think carefully about histogram binwidths
ggplot(faithful,
       aes(x = waiting)) +
  geom_histogram(binwidth = 2,
                 color = "black",
                 fill = "dodgerblue")

# load in some data for line plots
climate_data <- read.csv("data/climate.csv")

# line plot of climate anomaly over time at Berkeley
ggplot(data = climate_data,
       aes(x = Year,
           y = Anomaly10y)) +
  geom_line()

# line plot of climate anomaly over time at Berkeley
# with uncertainty
ggplot(data = climate_data,
       aes(x = Year,
           y = Anomaly10y)) +
  geom_ribbon(aes(ymin = Anomaly10y - Unc10y,
                  ymax = Anomaly10y + Unc10y),
              fill = "blue",
              alpha = 0.1) +
  geom_line(color = "steelblue")

# bar plots -- here be dragons
ggplot(data = iris,
       aes(x = Species,
           y = Sepal.Width)) +
  geom_bar(stat = "identity",
           color = "black",
           fill = "orange")

# more dragons
ggplot(data = long_iris,
       aes(x = Species,
           y = measurement,
           fill = flower_attribute)) +
  geom_bar(stat = "identity",
           position = "stack")

# dynamite (bar with error bars) plots
long_iris %>%
  group_by(Species, flower_attribute) %>%
  summarize(mean_measurement = mean(measurement),
            sd_measurement = sd(measurement)) %>%
  ggplot(aes(x = Species,
             y = mean_measurement,
             fill = flower_attribute)) +
  geom_errorbar(aes(ymin = mean_measurement - sd_measurement,
                    ymax = mean_measurement + sd_measurement),
                position = position_dodge2(width = 0.2,
                                           padding = 0.8)) +
  geom_col(position = "dodge")

# some additional themes are available in the ggthemes package
# this plot is bad because the regression gives the false conclusion
# that the relationship between sepal length and width is negative
# but this is just caused by species differences
mybadplot <- ggplot(iris,
       aes(x = Sepal.Length,
           y = Sepal.Width)) +
  geom_point(aes(shape = Species,
                 color = Species), size = 2) +
  geom_smooth(method = "lm",
              se = FALSE) +
  theme_few() +
  theme(legend.position = "bottom")

# how to save your plots to figures
ggsave(mybadplot,
       "bad_regression.tiff",
       width = 8,
       height = 10,
       dpi = 300)






