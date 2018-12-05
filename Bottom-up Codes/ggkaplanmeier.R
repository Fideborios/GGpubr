
# Load data
library(ggpubr) 
library(haven)
library(devtools)
library(ggkm)
devtools::install_github("sachsmc/ggkm")


# if there is not package installed 
# install.packages(ggpubr)
bladder   <- read_sav("Data/bladder.sav")

head(bladder)


bladder$gender =  factor(bladder$gender, labels = c("Male","Female"))
bladder$Stage =  factor(bladder$Stage, labels = c("pTa","pT1"))
bladder$Grade=  factor(bladder$Grade, labels = c("Good", "Moderate","Bad"))
bladder$solitaire=  factor(bladder$solitaire, labels = c("Solitaire","Multiple"))
bladder$Died=  as.numeric(bladder$Died)
bladder$Therapy = factor(bladder$Therapy, labels = c("TUR only", "TUR + Chemo","TUR + Radio"))




bladder$date_diff <-   as.numeric(as.Date(as.character(bladder$date_ovl), format="%Y-%m-%d") -
  as.Date(as.character(bladder$Date_diag), format="%Y-%m-%d"))

head(bladder$Died)

names(bladder)




ggplot(bladder, aes(time = date_diff, status = Died)) + geom_km()

## Basic usage
library(ggkm)
ggplot(bladder, aes(time = date_diff, status = Died)) + geom_km()
ggplot(bladder, aes(time = date_diff, status = Died)) + geom_km() + facet_wrap(~ Therapy)
ggplot(bladder, aes(time = date_diff, status = Died, color = Therapy)) + geom_km()

## Adding Tick marks
ggplot(bladder, aes(time = date_diff, status = Died)) + geom_km() + geom_kmticks()
ggplot(bladder, aes(time = date_diff, status = Died)) + geom_km() + geom_kmticks(shape = 1)

## Adding confidence bands

ggplot(bladder, aes(time = date_diff, status = Died, color = Therapy)) + geom_km() + geom_kmband()



ggplot(bladder, aes(time = date_diff, status = Died, color = Therapy,fill = Therapy)) + geom_km() + geom_kmband()
ggplot(bladder, aes(time = date_diff, status = Died, color = Therapy,fill = Therapy)) + geom_km() + geom_kmband(conf.int = .99)
ggplot(bladder, aes(time = date_diff, status = Died, color = Therapy,fill = Therapy)) + geom_km() + geom_kmband(conf.int = .99) + 
  facet_wrap(~ Therapy, labeller = "label_both")


## Tranformations


ggplot(bladder, aes(time = date_diff, status = Died)) + geom_km(trans = "cumhaz") + 
  geom_kmticks(trans = "cumhaz") + geom_kmband(trans = "cumhaz") + ylab("Cumulative hazard")
ggplot(bladder, aes(time = date_diff, status = Died)) + geom_km(trans = "event") + 
  geom_kmticks(trans = "event") + geom_kmband(trans = "event") + ylab("Cumulative Events (CDF)")
## proportional hazards -> parallel lines on cloglog scale
ggplot(bladder, aes(time = date_diff, status = Died, color = Therapy)) + geom_km(trans = "cloglog") + 
  geom_kmticks(trans = "cloglog") + geom_kmband(trans = "cloglog") + ylab("Complementary Log-Log") + scale_x_log10()







