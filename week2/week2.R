setwd("~/Desktop/Online Coursera/Coursera-Exploratory-Data-Analysis/week2")
## Lattice Plotting System
# lattice: produce Trellis graphics, xyplot, bwplot, levelplot
# grid: base of lattice
# xyplot(y ~ x | f * g, data) under some conditions
library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality) # Auto-printing
head(airquality)
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))
# Lattice graphics functions return ana object of class trellis.
p <- xyplot(Ozone ~ Wind, data = airquality)
print(p)

## Lattice Panel Functions
# Panel function controls what happens inside each panel of the plot.
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1))
# Custorm panel function
xyplot(y ~ x | f, panel = function(x, y, ...){
    panel.xyplot(x, y, ...) # First call the default panel function for 'xyplot'
    panel.abline(h = median(y), lty = 2)
    panel.lmline(x, y, col = 2)
} )

## ggplot2
# Grammar of graphics by Leland Wilkinson
# Written by hadley Wickham
library(ggplot2)
# qplot()
# looks for data in a data frame, similar to lattice,
# or in the parent environment
# plots = aesthetics(size, shape, color) and geoms(points, lines)
# Factors are important for indicating subsets of the data
str(mpg)
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, col = drv) # auto legend placement
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))
qplot(hwy, data = mpg, fill = drv)
qplot(displ, hwy, data = mpg, facets = . ~ drv)
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)
## MAACS data
load("./data/maacs.Rda")
head(maacs)
str(maacs)
# eno: Exhaled nitric oxide; pm25: Fine particulate matter
# mopos: Sensitized to mouse allergen
qplot(log(eno), data = maacs)
qplot(log(eno), data = maacs, fill = mopos)
# Density smooth
qplot(log(eno), data = maacs, geom = "density")
qplot(log(eno), data = maacs, geom = "density", col = mopos)
# Scatterplots
qplot(log(pm25), log(eno), data = maacs)
qplot(log(pm25), log(eno), data = maacs, shape = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos, 
      geom = c("point", "smooth"), method = "lm")
qplot(log(pm25), log(eno), data = maacs, geom = c("point", "smooth"), 
      method = "lm", facets = . ~ mopos)

## Basic componets of a ggplot2 plot
# A data frame
# aesthetic mappings: color, size
# geoms: geometric objects like points, lines, shapes
# facets: for conditional plots
# stats: statistical transformations like binning, quantiles, smoothing
# scales: what scale an aesthetic map uses
# coordinate system
# Plot the data -> overlay the summary -> metadata and annotation
qplot(logpm25, NocturnalSympt, data = maacs, facets = . ~ bmicat, 
      geom = c("point", "smooth"), method = "lm")
head(maacs[, 1:3])

g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
summary(g)
print(g) # no layers in plot
p <- g + geom_point()
print(p)
 
g + geom_point() # auto-print 
## Adding more layers
g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "lm")

g + geom_point() + facet_grid(. ~ bmicat) + geom_smooth(method = "lm")
# Annotation
# xlab(), ylab(), labs(), ggtitle()
# Modifying Aesthetics
g + geom_point(color = "steelblue", size = 4,
               alpha = 1 / 2) # sign a constant
g + geom_point(aes(color = bmicat), size = 4, alpha = 1 / 2) # wrap the non-constant
g + geom_point(aes(color = bmicat)) + labs(title = "MAACS Cohort") +
    labs(x = expression("log " * PM[2.5]), y = "Nocturnal Symptoms")
# labs() function for modifying titles and x- y- axis
g + geom_point(aes(color = bmicat), size = 2, alpha = 1/2) +
    geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)
# Changing the Theme
g + geom_point(aes(color = bmicat)) + theme_bw(base_family = "Times")

## A notes about axis limits
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50, 2] <- 100 ## Outlier
plot(testdat$x, testdat$y, type = "l", ylim = c(-3, 3))
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()
g + geom_line() + ylim(-3, 3) # outlier missing
g + geom_line() + coord_cartesian(ylim = c(-3, 3)) # outlier included

# Making No2 Tertiles
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, length = 4), na.rm = T)
maacs$no2dec <- cut(maacs$logno2_new, cutpoints)
levels(maacs$no2dec)

## Final plot
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
g + geom_point(alpha = 1/3)
  + facet_wrap(bmicat ~ no2dec, nrow = 2, ncol = 4)
  + geom_smooth(method = "lm", se = F, col = "steelblue")
  + theme_bw(base_family = "Avenir", base_size = 10)
  + labs(x = expression("log ") * PM[2.5])
  + labs(y = "Nocturnal Symptoms")
  + labs(title = "MAACS Cohort")

