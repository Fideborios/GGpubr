## ---- echo=FALSE, warning=FALSE, message=FALSE---------------------------

if(!require(haven)) install.packages("haven")
if(!require(knitr)) install.packages("knitr")
if(!require(dplyr)) install.packages("dplyr")
if(!require(qwraps2)) install.packages("qwraps2")
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(MASS)) install.packages("MASS")
if(!require(gapminder)) install.packages("gapminder")
if(!require(ggExtra)) install.packages("ggExtra")
if(!require(ggpubr))library(ggpubr)
if(!require(readxl))library(readxl)
if(!require(ggplot2))library(ggplot2)
if(!require(ggsci))library(ggsci)


opts_chunk$set(fig.width=9, fig.height=9, fig.path='Figs/', warning=FALSE, message=FALSE, fig.pos = "H", comment = "")


## ------------------------------------------------------------------------

bladder   <- read_sav("Data/bladder.sav")
surgery   <- read_sav("Data/surgery.sav")
skullrats <- read_sav("Data/SkullRats.sav")


## ------------------------------------------------------------------------
gg<- ggboxplot(surgery , # the data-set
            x = "gender", 
            y = "birthwt", # variable to be plotted
            color = "black", # paint the borders by Gender
            fill = "gender", # fill the boxes with color
            title = "Box-plot of birth-weight colored by gender", # a better title
            palette = "jco", # use the jco palette
            add = "mean", # or median
            bxp.errorbar = T  # adds the error bars of boxplots 
            ) +   
  theme(plot.title = element_text(hjust = 0.5))


## ----echo=FALSE----------------------------------------------------------
plot(gg)

## ------------------------------------------------------------------------

gg <-ggviolin(surgery ,
            x = "Gender", 
            y = "Weight", # variable to be plotted
          combine = TRUE, title="Violin-plot with boxplot",
          color = "Gender", palette = "jco",
          ylab = "Expression", 
          add = "boxplot")+   
  theme(plot.title = element_text(hjust = 0.5))


## ----echo=FALSE----------------------------------------------------------
plot(gg)

## ------------------------------------------------------------------------
gg<- ggdotplot(surgery ,
            x = "Gender", 
            y = "Weight", # variable to be plotted
            combine = TRUE, 
            color = "Gender", 
            palette = "jco",
            fill = "white",
            binwidth = 0.1,
            ylab = "Expression", 
            add = "median_iqr",
            add.params = list(size = 0.9)
          )

## ----echo=FALSE----------------------------------------------------------
plot(gg)

## ------------------------------------------------------------------------
gg<- gghistogram(surgery, 
            x= "Weight" ,   # variable to be plotted
            y= "..count..", # or "..density.."
            color = "Gender", # paint the borders by Gender
            fill = "Gender", # fill the bars with color
            bins = 25 , # control how many bars will the histogram have
            title = "Histogram of weight colored by gender", # a better title
            palette = "jco", # use the jco palette
            add = "mean", 
            add_density = T
            ) +   theme(plot.title = element_text(hjust = 0.5))


## ----echo=FALSE----------------------------------------------------------
plot(gg)

## ------------------------------------------------------------------------
gg <-  ggdensity(surgery, 
          x = "Weight",
          fill = "Gender",
          palette = "jco", 
          adjust = 3,
          title = "Density plot of weight", 
          linetype = "dotdash",color = "Gender",
          facet.by = "Gender",add = "mean" ) +   
  theme(plot.title = element_text(hjust = 0.5))

## ------------------------------------------------------------------------
plot(gg)

## ----echo=TRUE-----------------------------------------------------------

gapminder = gapminder
# Scatterplot
names(gapminder) =  c("Country","Continent","Year","Life_Expectancy",
                      "Population","GDP_per_capita_percentage")

gg = gapminder%>%
    filter(Year %in% "2007")%>%
ggplot( aes(GDP_per_capita_percentage, Life_Expectancy,size = Population, 
            color = Continent)) + # This is then main plot 
  ggtitle("Life expectancy association with GDP per capita percentage (in 2007)")+
  # a new title
  theme(plot.title = element_text(hjust = 0.5))+
    geom_point() + # insert the points of the parameters used in the general ggplot
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlab("GDP per capita") + # Change the label of X-axis
  ylab("Life Expectancy")+ # Change the label of Y-axis
  scale_x_log10() # log-Scale X values 


## ---- echo=FALSE---------------------------------------------------------
plot(gg)

## ------------------------------------------------------------------------
# Scatterplot


g = ggscatter(surgery , x = "Weight",y = "Height", 
              color = "Gender", palette = "jco",
              title = "Association of weight and height in males and females",
              xlab = "Weight measured in kilograms",
              ylab = "Height measured in centimeters", 
              shape = 1,
              ggtheme = theme_bw(),
              ellipse = T, 
              ellipse.alpha = 0.4,
              fill = "white"
              )



## ----echo=FALSE----------------------------------------------------------
plot(g)
# ggMarginal(g, type = "density", fill="transparent")

## ------------------------------------------------------------------------
ggMarginal(g, type = "histogram", fill="transparent")

## ----echo= FALSE---------------------------------------------------------
# ToothGrowth
data("ToothGrowth")
head(ToothGrowth)

## ------------------------------------------------------------------------
# Change error plot type and add mean points
ggerrorplot(ToothGrowth, x = "dose", y = "len", 
            desc_stat = "mean_sd",
            error.plot = "errorbar",            # Change error plot type
            add = "mean"                        # Add mean points
            )

## ----echo= FALSE---------------------------------------------------------
data1 <- read_excel("Data/Data for graphs.xlsx", 
                    sheet = "graph1")

## ------------------------------------------------------------------------
gg= ggbarplot(data = data1, #import  Data
          x="App",          # The X-value
          y="Proportion",   # The percentages
          fill="firebrick1",# The color of the bars
          xlab = "",        # label of X-axis
          title = "Bar chart of dating app percentage", # better title
          ylim = c(0,0.80), # Increase the ylimits
          ylab = "Share of respondents",
          order = c("Happn","Lexa","Paiq","Tinder","Badoo"))+   
  theme(plot.title = element_text(hjust = 0.5))+ 
  scale_y_continuous(breaks=seq(0,0.7,0.1),
                     labels=scales::percent)+
  geom_text(aes(label=paste(Proportion*100,"%",sep = "")),size=3,vjust=-1)



## ----echo=FALSE----------------------------------------------------------
plot(gg)

## ----echo=FALSE----------------------------------------------------------
data2 <- read_excel("Data/Data for graphs.xlsx", 
                    sheet = "Sheet2")


## ------------------------------------------------------------------------
gg= data2%>%
  arrange(desc(-freq))%>%
  ggbarplot( #import  Data
          x="website",          # The X-value
          y="freq",   # The percentages
          fill="nature",# The color of the bars
          xlab = "",        # label of X-axis
          title = "Online dating services in Netherlands (June 2014)", # better title
          ylim = c(0,300000), # Increase the ylimits
          ylab = "Share of respondents")+ rotate() +
  scale_y_continuous(breaks=seq(0,300000,50000),expand=c(0,0))+
    theme(legend.position =c(0.85,0.25),
          legend.title=element_text(size=8),
          legend.text=element_text(size=8),
          plot.title = element_text(hjust = 0.5))



## ------------------------------------------------------------------------
plot(gg)

## ------------------------------------------------------------------------


# Plot
gg= ggplot(data2,aes(x=reorder(website,freq), 
                     y=freq, color=nature, 
                     fill = nature)) + 
  geom_point(size=5,shape = 1) + 
  geom_segment(aes(x=website, xend=website, y=0, yend=freq)) + 
  labs(title="Lollipop Chart", 
       subtitle="Online dating services in Netherlands (June 2014)", 
       caption="source: Alexa.com") + scale_color_lancet()+
  theme(axis.text.x = element_text(angle=65, vjust=0.6))+
  geom_text(aes(label= freq),size=2,hjust=-0.35) + rotate()



## ------------------------------------------------------------------------
plot(gg)

