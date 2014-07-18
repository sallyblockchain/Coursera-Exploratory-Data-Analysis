## Quiz 2.
# Problem 1.
# Trellis object
# Problem 2.
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)
head(BodyWeight)
table(BodyWeight$Diet) # 1, 2, 3
# Problem 3.
# panel.lmline()
# Problem 4.
library(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)
print(p)
plot(p)
# Problem 5.
# trellis.par.set()
# Problem 6.
# ggplot2 -> the Grammar of Graphics developed by Leland Wilkinson
# Problem 7.
library(datasets)
data(airquality)
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)
# Problem 8.
# geom: a plotting object like point, line, or other shape
# Problem 9.
library(ggplot2)
g <- ggplot(movies, aes(votes, rating))
print(g) # ggplot does not yet know what type of layer to add to the plot.
# Problem 10.
qplot(votes, rating, data = movies)
# Add a smoother to the scatterplot
qplot(votes, rating, data = movies) + geom_smooth()
