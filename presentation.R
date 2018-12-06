## ----echo=FALSE, warning=FALSE, message=FALSE----------------------------
if(!require(haven)) install.packages("haven")
if(!require(dplyr)) install.packages("dplyr")
if(!require(ggpubr))library(ggpubr)
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(readxl))library(readxl)
if(!require(gapminder)) install.packages("gapminder")
if(!require(ggExtra)) install.packages("ggExtra")
if(!require(ggsci))library(ggsci)
library(knitr)

## ---- echo=FALSE, warning=FALSE, message=FALSE---------------------------
library(haven)
bladder   <- read_sav("Data/bladder.sav")
surgery   <- read_sav("Data/surgery.sav")
skullrats <- read_sav("Data/SkullRats.sav")

opts_chunk$set(fig.width=8, fig.height=8, fig.path='Figs/', warning=FALSE, message=FALSE, comment = "")


## ----eval=FALSE----------------------------------------------------------
theme(line, rect, text, title, aspect.ratio, axis.title, axis.title.x,
  axis.title.x.top, axis.title.x.bottom, axis.title.y, axis.title.y.left,
  axis.title.y.right, axis.text, axis.text.x, axis.text.x.top,
  axis.text.x.bottom, axis.text.y, axis.text.y.left, axis.text.y.right,
  axis.ticks, axis.ticks.x, axis.ticks.x.top, axis.ticks.x.bottom, axis.ticks.y,
  axis.ticks.y.left, axis.ticks.y.right, axis.ticks.length, axis.line,
  axis.line.x, axis.line.x.top, axis.line.x.bottom, axis.line.y,
  axis.line.y.left, axis.line.y.right, legend.background, legend.margin,
  legend.spacing, legend.spacing.x, legend.spacing.y, legend.key,
  legend.key.size, legend.key.height, legend.key.width, legend.text,
  legend.text.align, legend.title, legend.title.align, legend.position,
  legend.direction, legend.justification, legend.box, legend.box.just,
  legend.box.margin, legend.box.background, legend.box.spacing,
  panel.background, panel.border, panel.spacing, panel.spacing.x,
  panel.spacing.y, panel.grid, panel.grid.major, panel.grid.minor,
  panel.grid.major.x, panel.grid.major.y, panel.grid.minor.x,
  panel.grid.minor.y, panel.ontop, plot.background, plot.title, plot.subtitle,
  plot.caption, plot.tag, plot.tag.position, plot.margin, strip.background,
  strip.background.x, strip.background.y, strip.placement, strip.text,
  strip.text.x, strip.text.y, strip.switch.pad.grid, strip.switch.pad.wrap, ...,
  complete = FALSE, validate = TRUE)

## ----echo=FALSE----------------------------------------------------------
ggboxplot(surgery ,  # the data-set
            x = "gender", # the x-values is the categorical variable
            y = "birthwt" # the y-values is their values 
            )

## ----echo=FALSE----------------------------------------------------------
ggscatter(data = surgery, x = "birthwt", y = "gestatio")

## ----echo=FALSE----------------------------------------------------------
ggboxplot(data = surgery,x =  "gender", y = "birthwt",
          xlab = "Gender", ylab = "Birth Weight (in grams)",
          width = 0.5,add = "jitter", 
          shape = "gender",fill = "gender",palette = "simpsons",
          title = "A boxplot of weight at the time of birth",
          legend = "bottom",legend.title="Gender",font.legend = c(10, "bold", "darkgrey"),  
          font.main = c(18, "italic", "black"),
          subtitle = "Male and female infants compared ", font.subtitle = c(12, "bold.italic", "darkgreen"),
          ggtheme = theme_minimal()
) +   
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5)) + 
  stat_compare_means(method = "wilcox.test")#  Add a p-value


## ----echo=FALSE----------------------------------------------------------
ggscatter(data = surgery, x = "birthwt", y = "gestatio", combine = F, merge = T,
          color = "gender",fill = "gender", palette = "lancet", 
          shape = 1, size = 3,point = TRUE, rug = F, 
          title = "Scatterplot of gestational age and birth weight", 
          subtitle = "Faceted by infection information",
          xlab = "Birth weight (in grams)", ylab = "Gestational age",
          facet.by = "infect", 
          panel.labs = list(gender = c("Male", "Female")) , 
          short.panel.labs = TRUE,
          add = "reg.line" , # c("none", "reg.line", "loess")
          conf.int = T, conf.int.level = 0.95, fullrange = T, 
          ggtheme = theme_minimal(),
          label = "id", font.label = c(12, "italic"), font.family = "Comic Sans MS",
          cor.coef = T, cor.coeff.args = list(method = "pearson", ## "pearson", "kendall", or "spearman"
                                              label.x.npc = "left", label.y.npc = "top"),
          cor.coef.coord = c(2000, 42.5), cor.coef.size = 3,show.legend.text = T, 
          repel = T)+   
        theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

## ----echo=FALSE----------------------------------------------------------
bar_error=skullrats%>%
  group_by(age,treat)%>%
  summarize(mean.response = mean(response), 
            sd.response =  sd(response),
            n.res=n()) %>%
  mutate(sd.response=sd.response/sqrt(n.res),
         LCI=mean.response-qt(0.975,n.res-1)*sd.response,
         UCI=mean.response+qt(0.975,n.res-1)*sd.response)

ggplot(data=bar_error,aes(x=age,y=mean.response,ymin=LCI,ymax=UCI,colour=treat))+
  geom_point(size=1.5,position=position_dodge(width=3))+
  geom_line(size=1,position=position_dodge(width=3))+
  geom_errorbar(width=3,size=1,position=position_dodge(width=3))+
  ylab("Mean Response in pixels")+  scale_y_continuous(limits=c(65,90),breaks=seq(65,90,5),expand=c(0,0))+
  xlab("Age in days")+ scale_x_continuous(limits=c(40,121),breaks=seq(40,121,10),expand=c(0,0))+
  ggtitle("")+
  scale_colour_manual(name=" ",breaks=c("Control","Low dose", "High dose"),
                      values=c("red1","green1","blue1")) + theme_minimal() + theme(plot.title =element_text(hjust= 0.5))


## ------------------------------------------------------------------------
library(haven)
bladder   <- read_sav("Data/bladder.sav")
surgery   <- read_sav("Data/surgery.sav")
skullrats <- read_sav("Data/SkullRats.sav")


## ---- echo=FALSE, warning=FALSE, message=FALSE---------------------------
surgery$gender =  factor(surgery$gender, labels = c("Male","Female"))
surgery$place =  factor(surgery$place, labels = c(NA,"Outside regional","Local","Regional"))
surgery$infect=  factor(surgery$infect, labels = c("No","Yes"))
surgery$prematur=  factor(surgery$prematur, labels = c("Premature","Term"))
surgery$surgery=  factor(surgery$surgery, labels = c("Abdominal","Cardiac","Other"))


skullrats$treat =  factor(skullrats$treat, labels = c("High dose","Control","Low dose"))


bladder   <- read_sav("Data/bladder.sav")

bladder$gender =  factor(bladder$gender, labels = c("Male","Female"))
bladder$Stage =  factor(bladder$Stage, labels = c("pTa","pT1"))
bladder$Grade=  factor(bladder$Grade, labels = c("Good", "Moderate","Bad"))
bladder$solitaire=  factor(bladder$solitaire, labels = c("Solitaire","Multiple"))
bladder$Died=  as.numeric(bladder$Died)
bladder$Therapy = factor(bladder$Therapy, labels = c("TUR only", "TUR + Chemo","TUR + Radio"))

## ------------------------------------------------------------------------
gg<- ggboxplot(surgery ,  # the data-set
            x = "gender", # the x-values is the categorical variable
            y = "birthwt" # the y-values is their values 
            )

## ----echo=FALSE----------------------------------------------------------
plot(gg)

## ----eval=FALSE----------------------------------------------------------
ggboxplot(data, x, y, # load the data and choose the x and y variables
  combine = FALSE, merge = FALSE, color = "black", 
  fill = "white", palette = NULL, title = NULL, xlab = NULL,
  ylab = NULL, bxp.errorbar = FALSE, bxp.errorbar.width = 0.4,
  facet.by = NULL, panel.labs = NULL, short.panel.labs = TRUE,
  linetype = "solid", size = NULL, width = 0.7, notch = FALSE,
  select = NULL, remove = NULL, order = NULL, add = "none",
  add.params = list(), error.plot = "pointrange", label = NULL,
  font.label = list(size = 11, color = "black"), label.select = NULL,
  repel = FALSE, label.rectangle = FALSE, ggtheme = theme_pubr())

## ------------------------------------------------------------------------
gg <- ggboxplot(data = surgery,x =  "gender", y = "birthwt",
          xlab = "Gender", ylab = "Birth Weight (in grams)",
          width = 0.5,add = "jitter", 
          shape = "gender",fill = "gender",palette = "simpsons",
          title = "A boxplot of weight at the time of birth",
          legend = "bottom",legend.title="Gender",font.legend = c(10, "bold", "darkgrey"),  
          font.main = c(18, "italic", "black"),
          subtitle = "Male and female infants compared ", font.subtitle = c(12, "bold.italic", "darkgreen"),
          ggtheme = theme_minimal()
) +   
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5)) + 
  stat_compare_means(method = "wilcox.test")#  Add a p-value


## ----echo=FALSE----------------------------------------------------------
plot(gg)

## ------------------------------------------------------------------------
# Basic histogram plot
gghistogram(surgery, x = "birthwt")

## ------------------------------------------------------------------------
gg<- gghistogram(surgery, x = "birthwt",y = "..density..",add = "median",
            bins = 10 , # how many bars will the histogram have
            xlab = "Weight at birth (in grams)", ylab = "Density",
            title = "Histogram of infant weight at birth",
            fill = "gender",color = "grey",palette = "lancet",
            alpha = 0.2,legend = "bottom",legend.title="Gender",
            font.legend = c(10, "bold", "darkgrey"), facet.by = "infect", ggtheme = theme_minimal(), add_density = T )+   
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))


## ----echo=FALSE----------------------------------------------------------
plot(gg)

## ------------------------------------------------------------------------
# Basic Density plot 
ggdensity(surgery, x = "birthwt")

## ------------------------------------------------------------------------
gg <-  ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth",
            fill = "gender",color = "grey",palette = "lancet",
            alpha = 0.2,legend = "bottom",legend.title="Gender",
            font.legend = c(10, "bold", "darkgrey"), facet.by = "infect", ggtheme = theme_minimal() )+   
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

## ------------------------------------------------------------------------
plot(gg)

## ----echo=FALSE----------------------------------------------------------
# Scatterplot


gg = ggscatter(data = surgery, x = "birthwt", y = "gestatio", combine = F, merge = T,
          color = "gender",fill = "gender", palette = "lancet", 
          shape = 1, size = 3,point = TRUE, rug = F, 
          title = "Scatterplot of gestational age and birth weight", 
          subtitle = "Faceted by infection information",
          xlab = "Birth weight (in grams)", ylab = "Gestational age",
          facet.by = "infect", 
          panel.labs = list(gender = c("Male", "Female")) , 
          short.panel.labs = TRUE,
          add = "reg.line" , # c("none", "reg.line", "loess")
          conf.int = T, conf.int.level = 0.95, fullrange = T, 
          ggtheme = theme_minimal(),
          label = "id", font.label = c(12, "italic"), font.family = "Comic Sans MS",
          cor.coef = T, cor.coeff.args = list(method = "pearson", ## "pearson", "kendall", or "spearman"
                                              label.x.npc = "left", label.y.npc = "top"),
          cor.coef.coord = c(2000, 42.5), cor.coef.size = 3,show.legend.text = T, 
          repel = T)+   
        theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

plot(gg)
# ggMarginal(g, type = "density", fill="transparent")


## ----echo= FALSE---------------------------------------------------------
# Basic plot
ggline(skullrats, y= "response", x = "age", group= "rat", add = "point", xlab = "Age in days",numeric.x.axis = T)

## ------------------------------------------------------------------------
gg<- ggline(skullrats, y= "response", x = "age", add = "point",numeric.x.axis = T, 
      group= "rat",ylab = "Mean Response in pixels",xlab = "Age in days" , title = "Treatment",
      facet.by = "treat",
      legend.title = element_text(size=8),legend.text=element_text(size=7))+
  theme(plot.title = element_text(hjust=0.5,size = 10),
        legend.title = element_text(size=8),legend.text=element_text(size=7))

## ------------------------------------------------------------------------
skullrats%>%
    mutate(treat = factor(treat, levels = c("Control", "Low dose", "High dose")))%>%
  arrange(treat)%>%
ggline( y= "response", x = "age", add = "point",numeric.x.axis = T,
      group= "rat",ylab = "Mean Response in pixels",xlab = "Age in days" , title = "Treatment",
      facet.by = "treat",
      legend.title = element_text(size=8),legend.text=element_text(size=7))+
  theme(plot.title = element_text(hjust=0.5,size = 10),
        legend.title = element_text(size=8),legend.text=element_text(size=7))

## ----echo=FALSE----------------------------------------------------------

ggplot(data=bar_error, aes(x=age,y=mean.response,ymin=LCI,ymax=UCI,colour=treat))+
  geom_point(size=1.5,position=position_dodge(width=3))+
  geom_line(size=1,position=position_dodge(width=3))+
  geom_errorbar(width=3,size=1,position=position_dodge(width=3))+
  ylab("Mean Response in pixels")+  scale_y_continuous(limits=c(65,90),breaks=seq(65,90,5),expand=c(0,0))+
  xlab("Age in days")+ scale_x_continuous(limits=c(40,121),breaks=seq(40,121,10),expand=c(0,0))+
  ggtitle("")+
  scale_colour_manual(name=" ",breaks=c("Control","Low dose", "High dose"),
                      values=c("red1","green1","blue1")) + theme_minimal() + theme(plot.title =element_text(hjust= 0.5))


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

## ----echo=FALSE, message= FALSE------------------------------------------

library(knitr)
purl("presentation.Rpres")


