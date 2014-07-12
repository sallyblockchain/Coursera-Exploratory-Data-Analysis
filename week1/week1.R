### Exploratory Data Analysis
# Principle 1: Show comparisons - a 'is relative to' b
# Principle 2: Show causality, mechanism, explanation, systematic structure
# Principle 3: Show multivariate data - more than 2 variables
# Principle 4: Integration of evidence - words, numbers, images, diagrams 
# Principle 5: Describe and document the evidence with appropriate labels, 
#              scales, sources, etc.
# Principle 6: Content is king

## Why Exploratory Graphs?
# R1. To understand data properties
# R2. To find patterns in data
# R3. To suggest modeling strategies
# R4. To "debug" analyses
# 5. To communicate results 
getwd()
setwd("~/Desktop/Online Coursera/Coursera-Exploratory-Data-Analysis/")
list.files()
pollution <- read.csv("data/avgpm25.csv", colClasses=c("numeric", "character", "factor","numeric", "numeric"))
head(pollution)
attach(pollution)
# Five numbers
summary(pm25)
# Boxplot
boxplot(pm25, col="blue")
# Histogram
hist(pm25, col="green")
rug(pm25) # underneath 
hist(pm25, col="green", breaks=100)
rug(pm25) # underneath 
# Overlaying Features
boxplot(pm25, col="blue")
abline(h=12)
hist(pm25, col="green")
abline(v=12, lwd=2)
abline(v=median(pm25), col="magenta", lwd=4)
# Barplot
barplot(table(region), col="wheat", main="Number of Counties in Each Region")
## Simple Summaries of Data
# Two dimensions: Lattice/ggplot2, (Smooth) Scatterplots
# >2 dimensions: coplots, Spinning plots
# Multiple Boxplots:
boxplot(pm25 ~ region, data=pollution, col="red")
# Multiple Histograms
par(mfrow=c(2,1), mar=c(4,4,2,1))
hist(subset(pollution, region=="east")$pm25, col="green")
hist(subset(pollution, region=="west")$pm25, col="green")
# Scatterplot
with(pollution, plot(latitude, pm25))
abline(h=12, lwd=2, lty=2)
# Scatterplot - using color
with(pollution, plot(latitude, pm25, col=region))
abline(h=12, lwd=2, lty=2)
# Multiple Scatterplots
par(mfrow=c(1,2), mar=c(5,4,2,1))
with(subset(pollution, region=="west"), plot(latitude, pm25, main="West"))
with(subset(pollution, region=="east"), plot(latitude, pm25, main="East"))
## Plotting Systems in R
# The Base plotting system - blank canvas, "artist's palette" model
library(datasets)
data(cars)
with(cars, plot(speed, dist))
# The Lattice system - entire plot specified by one function; conditioning
library(lattice)
state <- data.frame(state.x77, region=state.region)
xyplot(Life.Exp ~ Income | region, data=state, layout=c(4,1))
# ggplot2 system - mixes elements of Base and Lattice
library(ggplot2)
data(mpg)
qplot(displ, hwy, data=mpg)
## Base Plotting System
# - graphics
# - grDevices
# 1. Initializing a new plot - plot(x,y), hist(x)
# 2. Annotating an existing plot
library(datasets)
hist(airquality$Ozone) # Draw a new plot
with(airquality, plot(Wind, Ozone))
airquality <- transform(airquality, Month=factor(Month))
boxplot(Ozone ~ Month, airquality, xlab="Month", ylab="Ozone(ppb)")
# pch(plotting symbol), lty(line type), lwd(line width), 
# col(plotting color), xlab(x-axis label), ylab(y-axis label))
# las(orientation of the axis labels), bg, 
# mar(margin size), oma(outer margin size), mfrow(row-wise), mfcol
par("lty") # "solid"
par("col") # "black
par("pch") # 1
par("bg")  # "white"
par("mar") # 5.1 4.1 4.1 2.1
par("mfrow") # 1 1
## Base Plotting Functions
# plot(scatterplot), lines, points, text, title, 
# mtext(arbitrary text to the margins), axis
library(datasets)
with(airquality, plot(Wind, Ozone))
title(main="Ozone and Wind in New York City")
with(airquality, plot(Wind, Ozone), main="Ozone and Wind in New York City")
with(subset(airquality, Month=5), points(Wind, Ozone, col="blue"))
#
with(airquality, plot(Wind, Ozone), 
     main="Ozone and Wind in New York City", type="n")
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="red"))
legend("topright", pch=1, col=c("blue", "red"), legend=c("May", "Other Months"))
# Add a regression line
with(airquality, plot(Wind, Ozone), 
     main="Ozone and Wind in New York", pch=20)
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd=2)
# Multiple Base Plots
par(mfrow=c(1,2)) # 1 row, 2 columns
with(airquality, {
    plot(Wind, Ozone, main="Ozone and Wind")
    plot(Solar.R, Ozone, main="Ozone and Solar Radiation")
})
par(mfrow=c(1,3), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(airquality, {
    plot(Wind, Ozone, main="Ozone and Wind")
    plot(Solar.R, Ozone, main="Ozone and Solar Radiation")
    plot(Temp, Ozone, main="Ozone and Temperature")
    mtext("Ozone and Weather in New York City", outer=TRUE)
})
## Base Plotting Demonstration
x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x, y)
par(mar=c(4, 4, 2, 2))
plot(x, y, pch=20)
plot(x, y, pch=2)
example(points)
title("Scatterplot")
text(-2, -2, "label")
legend("topleft", legend="Data", pch=20)
fit <- lm(y ~ x)
abline(fit, lwd=3, col="blue")
plot(x, y, xlab="Weight", ylab="Height", main="Scatterplot")
legend("topright", legend="Data", pch=20)
fit <- lm(y ~ x)
abline(fit, lwd=3, col="red")
z <- rpois(100, 2)
par(mfrow=c(2, 1))
plot(x, y, pch=20)
plot(x, z, pch=19)
par("mar")
par(mar=c(2, 2, 1, 1))
par(mfrow=c(2, 2))
plot(x, y)
plot(x, z)
plot(z, x)
plot(y, x)
par(mfrow=c(1, 1))
x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2, 50, labels=c("Male", "Female"))
str(g)
plot(x, y)
plot(x, y, type="n") # no points
points(x[g=="Male"], y[g=="Male"], col="green")
points(x[g=="Female"], y[g=="Female"], col="blue", pch=19)
## Graphics Devices in R
# 1. screen device
# 2. file device
# 3. SVG
# quartz() - Mac
# plot(base), xyplot(lattice), qplot(ggplot2)
library(datasets)
pdf(file="myplot.pdf")
with(faithful, plot(eruptions, waiting))
title(main="Old Faithful Geyser data")
dev.off()
list.files()
# Vector formats: pdf, svg(scalable vector graphics)
#                 win.metafile, postscript
# Bitmap formats: png(line drawings, lossless compression), GIF 
# jpeg(lossy compression), tiff, bmp
dev.cur() # returns an int
dev.set(2)
# Copying plots
dev.copy
dev.copy2pdf
library(datasets)
with(faithful, plot(eruptions, waiting))
title(main="Old Faithful Geyser data")
dev.copy(png, file="geyserplot.png")
dev.off()
