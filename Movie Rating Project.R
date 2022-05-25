getwd()
setwd("E:/Courses/Super Data Science/R Programming A-Z/6. Advanced Visualization")
movies <- read.csv("Movie-Ratings.csv")
library(ggthemes)
head(movies)
colnames(movies) <- c("Film", "Genre","CriticRating","AudienceRating","BudgetInMillion","Year")
head(movies)
tail(movies)
str(movies)
summary(movies)

#Convert Year to factor
factor(movies$Year)
movies$Year <- factor(movies$Year)

summary(movies)
str(movies)
#---------------------------------------Aesthetics
#import library
library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) #aes=aesthetics

#Add Geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) +
  geom_point()

#Add colour
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetInMillion)) +
  geom_point()

#---------------------------------------Plotting with Layers

p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetInMillion)) +
  geom_point()

#point
p + geom_point()

#lines
p + geom_line()

#multiple layers
p+ geom_point() + geom_line()
p+ geom_line() + geom_point()

#---------------------------------------Overriding Aesthetics

q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetInMillion)) +
  geom_point()

#add geom layer
q + geom_point()


#Overriding Aes
#Ex1
q + geom_point(aes(size=CriticRating))

#Ex2
q + geom_point(aes(colour=BudgetInMillion))

q + geom_point()

#Ex3
q + geom_point(aes(x=BudgetInMillion)) +
  xlab("Budget Millions $$$")

#Ex4
q + geom_line(size=0.5) + geom_point()

#---------------------------------------Mapping VS Setting

r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()            

#Add Colour
#1. Mapping:
r + geom_point(aes(colour=Genre))
#2. Setting:
r + geom_point(colour="DarkGreen")
r + geom_point(size=3.5, shape=1, aes(colour=Genre)) + 
  theme_economist()
#ERROR:
#r + geom_point(aes(colour="DarkGreen"))

#---------------------------------------Histogram and Density Chart

s <- ggplot(data=movies, aes(x=BudgetInMillion))
s+ geom_histogram(binwidth = 10)

#add colour
s+ geom_histogram(binwidth = 10, aes(fill=Genre))

#add a border
s+ geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black") + 
  theme_economist()

#Improve the Charts

#Density Charts
s+ geom_density(aes(fill=Genre), position="stack") + 
  theme_economist()

#---------------------------------------Starting Layer Tips
t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10,
                   fill="White", colour="Blue")

#Another Way:
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10,
                   aes(x=AudienceRating),
                   fill="White", colour="Blue") + 
  theme_economist()
# 4th chart

t + geom_histogram(binwidth = 10,
                   aes(x=CriticRating),
                   fill="White", colour="Blue") + 
  theme_economist()

#---------------------------------------Statistical Transformation

?geom_smooth

u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             colour=Genre))
u + geom_point() + geom_smooth(fill=NA) + 
  theme_economist()

#Boxplot
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating,
                             colour=Genre))
u + geom_boxplot(size=1.2) + geom_point() + theme_economist()

#Other Methods:
u + geom_boxplot(size=1.2) + geom_jitter() + theme_economist()

u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5) + theme_economist()

#---------------------------------------Using Facet

v <- ggplot(data=movies, aes(x=BudgetInMillion))
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black") + theme_economist()

#Facets:
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black") +
  facet_grid(Genre~., scales="free")

#Scatterplots
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             colour=Genre))
w + geom_point(size=3)

#Facets
w + geom_point(size=2) +
  facet_grid(Genre~.)

w + geom_point(size=2) +
  facet_grid(.~Year)

w + geom_point(size=2) +
  geom_smooth() +
  facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetInMillion)) +
  geom_smooth() +
  facet_grid(Genre~Year)

#---------------------------------------Coordinates
#Limits and Zoom

m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             size=BudgetInMillion, colour=Genre))
m + geom_point() + 
  xlim(50,100) + 
  ylim(50,100)

#Won't work well always
n <- ggplot(data=movies, aes(x=BudgetInMillion))
n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black") +
  ylim(0,50)

#Using Zoom:
n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black") +
  coord_cartesian(ylim=c(0,50))

#Improve #1:
w + geom_point(aes(size=BudgetInMillion)) + geom_smooth() + 
  facet_grid(Genre~Year) +
  coord_cartesian(ylim=c(0,100))

#---------------------------------------Theme

o <- ggplot(data=movies, aes(x=BudgetInMillion))
h <- o + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")
h

#Axis Labels
h + xlab("Money Axis") + 
  ylab("Number of Movies")

#Label Formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") + 
  theme(axis.title.x= element_text(colour="DarkGreen", size=30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))

#Legend Formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") + 
  theme(axis.title.x= element_text(colour="DarkGreen", size=30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1), #top right corner
        legend.justification = c(1,1)
        )

#Title
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") + 
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x= element_text(colour="DarkGreen", size=30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1), #top right corner
        legend.justification = c(1,1),
        
        plot.title = element_text(colour = "DarkBlue",
                                  size=40,
                                  family="Courier")
  )

#2nd Data
mov <- read.csv("Homework-Data.csv")
head(mov)
str(mov)
summary(mov)

ggplot(data=mov, aes(x=Day.of.Week)) + 
  geom_bar()

#filter #1 for the Data Frame
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation")|(mov$Genre == "comedy")|(mov$Genre == "drama")

#filter #2
filt2 <- mov$Studio %in% c("Buena Vista Studios","WB","Fox","Universal","Sony","Paramount Pictures")

filt
filt2

mov2 <- mov[filt & filt2,]
mov2

#prepare the plot's data and aes layers

e <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))
e

#add geometries
f <- e + geom_jitter(aes(size=Budget...mill., colour=Studio)) + 
  geom_boxplot(alpha=0.7, outlier.color =NA)
f

#Non-data ink
f <- f +
  xlab("Genre") +
  ylab("Gross % US") +
  ggtitle("Domestic Gross % by Genre")
f

#Theme
f <- f +
  theme(
    axis.title.x = element_text(colour="Blue",
                                size=30),
    axis.title.y = element_text(colour = "Blue",
                                size=30),
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),
    
    plot.title = element_text(size = 40),
    legend.title = element_text(size=20),
    
    text = element_text(family = "Comic Sans MS")
  )
f

#Final Touch
f$labels$size <- "Budget $M"
f
