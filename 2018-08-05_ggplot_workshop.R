# Sample code for ggplot2 workshop at ESA 2018
# Naupaka Zimmerman
# August 5, 2018
# nzimmerman@usfca.edu

# load libraries
library("ggplot2")
library("tidyr")
library("dplyr")

# iris is wide data
head(iris)

# convert wide to long using tidyr
df <- gather(iris,
             key = flower_attribute,
             value = measurement,
             -Species)

myplot <- ggplot(data = iris,
                 aes(x = Sepal.Length,
                     y = Sepal.Width))

summary(myplot)

# our first plot!
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width)) +
  geom_point()

# our first plot, with bigger points!
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width)) +
  geom_point(size = 3)

# our first plot, mapping color!
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point(size = 3)

# our first plot, mapping color and shape!
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point(size = 3,
             aes(shape = Species))

View(diamonds)

# Exercise 1
ggplot(data = diamonds) +
  geom_point(aes(x = carat,
                 y = price,
                 color = color))


View(birthwt)

# stats!
library("MASS")
myplot <- ggplot(data = birthwt,
       aes(x = factor(race),
           y = bwt)) +
  geom_boxplot()

summary(myplot)

# facet_grid example
ggplot(iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point() +
  facet_grid(. ~ Species)

# facet_wrap example
ggplot(iris,
       aes(x = Sepal.Length,
           y = Sepal.Width)) +
  geom_point() +
  facet_wrap( ~ Species)

# adjusting the scale for color mapping
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point(color = "dodgerblue")

my_point_colors <- c("#9d63cb",
                      "#6e8bc8",
                      "#c55e98")

# adjusting the scale for color mapping manually
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point() +
  scale_color_manual(values = my_point_colors)

install.packages("RColorBrewer")
library("RColorBrewer")

display.brewer.all()

# adjusting the scale for color mapping with brewer
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point() +
  scale_color_brewer(palette = "BrBG")


# adjust a continuous scale
ggplot(data = birthwt,
       aes(x = factor(race),
           y = bwt)) +
  geom_boxplot(width = 0.2) +
  scale_y_continuous(labels = paste0(1:4, " kg"),
                     breaks = seq(1000, 4000, by = 1000))

View(faithful)

# histogram of Old Faithful
ggplot(faithful,
       aes(x = waiting)) +
  geom_histogram(binwidth = 3,
                 color = "black",
                 fill = "blue")

# line plot with climate data
climate <- read.csv("esa_ggplot2_2018-master/data/climate.csv",
                    header = TRUE)

# line plot of climate anomaly over time at Berkeley
ggplot(data = climate,
       aes(x = Year,
           y = Anomaly10y)) +
  geom_line()

# line plot of climate anomaly over time at Berkeley
ggplot(data = climate,
       aes(x = Year,
           y = Anomaly10y)) +
  geom_ribbon(aes(ymin = Anomaly10y - Unc10y,
                  ymax = Anomaly10y + Unc10y),
              fill = "blue",
              alpha = 0.1) +
  geom_line(color = "steelblue")

# bar plot
ggplot(data = iris,
       aes(x = Species,
           y = Sepal.Length)) +
  geom_bar(stat = "identity")

# bar plot
ggplot(data = df,
       aes(x = Species,
           y = measurement,
           fill = flower_attribute)) +
  geom_bar(stat = "identity",
           position = "dodge",
           color = "black")

library("dplyr")
df %>%
  group_by(Species, flower_attribute) %>%
  summarise(mean_measure = mean(measurement)) %>%
  ggplot(aes(x = Species,
             y = mean_measure,
             fill = flower_attribute)) +
  geom_col(position = "dodge")

# density plot
ggplot(data = faithful,
       aes(x = waiting)) +
  geom_density(fill = "blue",
               alpha = 0.1)

ggplot(data = faithful,
       aes(x = waiting)) +
  geom_line(stat = "density")

# fitting models
ggplot(iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point(aes(shape = Species), size = 2) +
  geom_smooth(method = "lm")

library("ggthemes")

ggplot(iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species)) +
  geom_point(aes(shape = Species), size = 2) +
  geom_smooth(method = "lm") +
  facet_grid(. ~ Species) +
  theme_economist() +
  theme(legend.position = "bottom")


