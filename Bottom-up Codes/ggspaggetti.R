# Load data
library(ggpubr) 
library(haven)
library(dplyr)

# if there is not package installed 
# install.packages(ggpubr)
skullrats <- read_sav("Data/SkullRats.sav")



head(skullrats)
summary(skullrats)


skullrats$treat =  factor(skullrats$treat, labels = c("High dose","Control","Low dose"))
skullrats$t  =  as.numeric(skullrats$t) 

# Basic plot
ggplot(skullrats,aes(y= response, x = t)) + geom_point()
ggline(skullrats, y= "response", x = "t", group= "rat", add = "point", xlab = "time") +
  scale_y_continuous(limits=c(65,92.5),breaks=seq(65,92.5,5),expand=c(0,0))+
  scale_x_continuous(limits=c(-0.25,2.25),breaks=seq(0,2,0.5))
# Basic plot + lines 
ggplot(skullrats,aes(y= response, x = t, group = rat)) + geom_point() + geom_line()


## facet (condition) the graph base on the treat variable
ggplot(skullrats,aes(y= response, x = t, group = rat)) + geom_point() + geom_line() + facet_grid(. ~ treat)+ 
  stat_summary(aes(group = 1), geom = "point", fun.y = mean, shape = 17, size = 3) + facet_grid(. ~ treat)


ggplot(data=skullrats,aes(x=age,y=response,color=as.factor(rat)))+
  geom_point()+geom_line()+facet_wrap(~treat)+
  theme(legend.title = element_text(size=8),legend.text=element_text(size=7))+
  ylab("Mean Response in pixels")+scale_y_continuous(limits=c(65,92.5),breaks=seq(65,92.5,5),expand=c(0,0))+
  xlab("Age in days")+scale_x_continuous(limits=c(50,110),breaks=seq(50,110,10))+
  scale_color_discrete(name="Rat")+ggtitle("Treatment")+theme(plot.title = element_text(hjust=0.5,size = 10))


