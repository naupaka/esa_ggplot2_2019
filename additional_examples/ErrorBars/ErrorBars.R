#Load libraries
library(ggplot2)
library(ggthemes)
library(grid)
library(gridExtra)
library(plyr)
library(scales)

#read in data (change 'datafile' to match your computer)
datafile <- "GrazingData.csv"
data <- read.csv(file=datafile, header=TRUE)
head(data)
#remove 'X' column
data <- data[,2:4]
head(data)

df.avg <- ddply(data, .(grazed, nutadd), summarize,
                mean.biomass = mean(biomass), 
                sd.biomass = sd(biomass),
                se.biomass = sd(biomass)/sqrt(length(biomass)))


#The bars and the errorbars will have different widths, so...
#we need to specify how wide the objects we are dodging are
dodge <- position_dodge(width=0.9)

#Create a sophisticated label for the y-axis
y.label <- expression(paste("Biomass (g ", m^-2, ")"))

#now start the plot
myplot <- ggplot(data=df.avg, aes(y=mean.biomass, x=grazed, fill=nutadd)) +
  #adds the bars
  geom_bar(position=dodge, stat="identity") + 
  #adds the errorbars by adding/subtracting std. devs.
  geom_errorbar(position=dodge, aes(ymin=(mean.biomass-sd.biomass), 
                                    ymax=(mean.biomass+sd.biomass)),
                width=0.15)+ 
  #adds desired x and y axis labels
  ylab(y.label) + xlab("Grazing Treatment") + 
  #desired labels for x axis
  scale_x_discrete(labels=c("Not Grazed", "Grazed")) + 
  scale_fill_grey(start=0.5, end=0.8,
                  #set colors and labels for bar groups
                  labels = c("Nutrient Added", "No Nutrient Added")) + 
  #set theme from 'ggthemes'
  theme_classic() + 
  
  #add extra theme modifications
  theme(legend.position = c(0.75,0.9), #position legend in plot
        legend.title = element_blank(), #no legend title
        legend.key = element_blank(), #no legend ky
        legend.background = element_rect(colour = NA), #no legend background color
        legend.key.height = unit(5, "mm") #set height of legend (requires 'grid' library)
  ) 

#print plot to window
myplot

#save the plot as a pdf (change file variable first)
file = "Grazing.pdf"
ggsave(filename=file, plot=myplot, width=4, height=4, units="in")