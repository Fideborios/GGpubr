library(readxl)
library(ggplot2)

data1 <- read_excel("Data/Data for graphs.xlsx", 
                    sheet = "graph1")
View(data1)


ggbarplot(data1, x="App",y="Proportion")
graph1= ggplot(data=data1,aes(x=App,y=Proportion))+
geom_bar(stat="identity",fill="blue")
graph1

# reorder category
graph1 = ggplot(data=data1,aes(x=reorder(App,-Proportion),y=Proportion))+
  geom_bar(stat="identity",fill="blue")
graph1


#percentage scale
graph1 = graph1 + scale_y_continuous(labels=scales::percent)
graph1

#relabel the axis
graph1=graph1+xlab("")+ylab("Share of respondents")
graph1

#y axis 0 to 70
graph1=graph1+ scale_y_continuous(breaks=seq(0,0.7,0.1),
                                  labels=scales::percent)
graph1 

#remove indent at zero
graph1=graph1+ scale_y_continuous(breaks=seq(0,0.7,0.1),
                                  labels=scales::percent,
                                  expand=c(0,0))
graph1 

#force y-axis to go up to 70%
graph1=graph1+scale_y_continuous(limits=c(0,0.7),
                                 breaks=seq(0,0.7,0.1),
                                 labels=scales::percent,
                                 expand=c(0,0))
graph1

#add numbers to the graph
graph1=graph1+geom_text(aes(label=Proportion*100),size=3,vjust=-1)
graph1

########################GRAPH 2#############################
library(readxl)
data2 <- read_excel("Data/Data for graphs.xlsx", 
                    sheet = "Sheet2")
View(data2)

#Simple plot
graph2 = ggplot(data=data2,aes(x=reorder(website,freq),y=freq,fill=nature))+
  scale_y_continuous(limits=c(0,300000),breaks=seq(0,300000,50000),expand=c(0,0))+
  geom_bar(stat="identity")
graph2

#flip the axis and remove axis labels
graph2 = graph2+coord_flip() + ylab("")+xlab("")
graph2

#fix the legend
graph2=graph2+
  scale_fill_discrete(name="Relationship\nnature",breaks=c("Romantic relationship","Friendly relationship","Sexual relationship"),labels=c("Romantic","Friendly","Sexual"))+
  theme(legend.position = c(0.85,0.25),legend.title=element_text(size=8),legend.text=element_text(size=8))
graph2

#note difference between scale_fill_discrete
#and scale_color_discrete

#adjust scale limits on x axis and add numbers to the plot
#adjusting the scale limits must be done before flipping the coordinates.
graph2=graph2+geom_text(aes(label=freq),size=3,hjust=-0.1)
graph2

##add a title
graph2=graph2+ggtitle("Online dating services in the Netherlands in June 2014")
graph2


##aesthetics

#Remove the background grey 
#must be added at the begining.
#+theme_minimal()

graph2 = ggplot(data=data2,aes(x=reorder(website,freq),y=freq,fill=nature))+theme_minimal() +
  scale_y_continuous(limits=c(0,300000),breaks=seq(0,300000,50000),expand=c(0,0))+
  geom_bar(stat="identity")+coord_flip() + ylab("")+xlab("")+
  scale_fill_discrete(name="Relationship\nnature",breaks=c("Romantic relationship","Friendly relationship","Sexual relationship"),labels=c("Romantic","Friendly","Sexual"))+
  theme(legend.position = c(0.85,0.25),legend.title=element_text(size=8),legend.text=element_text(size=8))+
  geom_text(aes(label=freq),size=3,hjust=-0.1)+
  ggtitle("Online dating services in the Netherlands in June 2014")
graph2


#or remove grey and the grids
#+theme_bw() +theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"))

graph2 = ggplot(data=data2,aes(x=reorder(website,freq),y=freq,fill=nature))+theme_bw() +theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_y_continuous(limits=c(0,300000),breaks=seq(0,300000,50000),expand=c(0,0))+
  geom_bar(stat="identity")+coord_flip() + ylab("")+xlab("")+
  scale_fill_discrete(name="Relationship\nnature",breaks=c("Romantic relationship","Friendly relationship","Sexual relationship"),labels=c("Romantic","Friendly","Sexual"))+
  theme(legend.position = c(0.85,0.25),legend.title=element_text(size=8),legend.text=element_text(size=8))+
  geom_text(aes(label=freq),size=3,hjust=-0.1)+
  ggtitle("Online dating services in the Netherlands in June 2014")
graph2

##Make a wider gap between bars
#must also be added in the begining
#+geom_bar(stat="identity",position=position_dodge(width=0.5))

graph2 = ggplot(data=data2,aes(x=reorder(website,freq),y=freq,fill=nature))+theme_bw() +theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_y_continuous(limits=c(0,300000),breaks=seq(0,300000,50000),expand=c(0,0))+
  geom_bar(stat="identity",position=position_dodge(width=1))+coord_flip() + ylab("")+xlab("")+
  scale_fill_discrete(name="Relationship\nnature",breaks=c("Romantic relationship","Friendly relationship","Sexual relationship"),labels=c("Romantic","Friendly","Sexual"))+
  theme(legend.position = c(0.85,0.25),legend.title=element_text(size=8),legend.text=element_text(size=8))+
  geom_text(aes(label=freq),size=3,hjust=-0.1)+
  ggtitle("Online dating services in the Netherlands in June 2014")
graph2

##changing colours
#darker version of the standard red/green/blue
graph2+scale_fill_hue(l=40,c=35)



##Using RColorBrewer palettes
#You can google to find the different palettes and codes. Example:
graph2+scale_fill_brewer(palette="Dark2")


##Manual colours
graph2+scale_fill_manual(values=c("#999999","#E69F00","#56B4E9"))


##Manual colours
graph2+scale_fill_manual(values=c("red","blue","green"))


########GRAPH 3###############
library(readxl)
data3 <- read_excel("Data/Data for graphs.xlsx", 
                    sheet = "graph4")
head(data3)

## Basic plot
graph3=ggplot(data=data3, aes(x=App,y=Proportion,ymin=LCI, ymax=UCI))+
  geom_point()+geom_errorbar(width=0.25)
graph3

## Can try some of the fancy code from the previous barplot.
graph3=ggplot(data=data3,aes(x=reorder(App,-Proportion),y=Proportion,ymin=LCI,ymax=UCI))+
  theme_minimal()+geom_point()+geom_errorbar(width=0.25)+
  scale_y_continuous(limits=c(0,0.8),breaks=seq(0,0.8,0.1),labels=scales::percent,expand=c(0,0))+
  xlab("")+ylab("Share of respondents")+
  geom_text(aes(label=Proportion*100),size=3,hjust=-1)

graph3

##########GRAPH 4#############

library(readxl)
data4 <- read_excel("Data/Data for graphs.xlsx", sheet = "Sheet3")
head(data4)

## Simple plot
graph4 = ggplot(data=data4,aes(x=year,y=proportion,color=how))+
  geom_point()+geom_line()
graph4

## Seperate by sexual orientation
graph4a = ggplot(data=data4[data4$orientation=="Heterosexual Couples",],aes(x=year,y=proportion,color=how))+
  geom_point()+geom_line()
graph4a

graph4b = ggplot(data=data4[data4$orientation=="Homosexual Couples",],aes(x=year,y=proportion,color=how))+
  geom_point()+geom_line()+facet_grid(~ orientation)
graph4b


## Together
graph4=graph4+facet_wrap(~orientation)
graph4

## Exercise: Now code your plot to look like this:
graph4 = graph4+theme_minimal()+xlab("Year Couple Met")+ylab("percentage who met this way")+
  scale_y_continuous(limits=c(0,0.7),breaks=seq(0,0.7,0.1),labels=scales::percent,expand=c(0,0))+
  scale_x_continuous(limits=c(1990,2014),breaks=seq(1990,2014,10),expand=c(0,0))+
  theme(legend.position = c(0.2,0.8))+geom_point(aes(shape=how))+scale_shape(guide=FALSE)+
  scale_color_discrete(name="",breaks=c("Met Online","Met through Friends","Bar/Restaurant"))
  
graph4  



## Assignment

#1. Replicate the following graph. The data can be found in CLI_data_long.sav

library(haven)
CLI_data_long <- read_sav("Data/CLI_data_long.sav")
head(CLI_data_long)

ggplot(data=CLI_data_long,aes(x=Day,y=RelativePerfusion,color=Muis))+
  geom_point()+geom_line()+facet_wrap(~Group)+
  theme(legend.title = element_text(size=8),legend.text=element_text(size=7))+
  ylab("Mean Relative Perfusion")+scale_y_continuous(limits=c(0,1.3),breaks=seq(0,1.3,0.2),expand=c(0,0))+
  scale_x_continuous(limits=c(0,14.5),breaks=seq(0,14.5,1))
  
#In order to get the plot above by Donor instead of by muis,
#we would need to use the dplyr package to summarize the data.
#This is because there are multiple observations for the same donor 
#across the different days. We will need to find the means.

mean_data<-group_by(CLI_data_long,Donor,Day,Group) %>%
            dplyr::summarise(RelativePerfusion=mean(RelativePerfusion,na.rm=TRUE))
View(mean_data)

#Now it should be easy to complete the plot using your previos code.

ggplot(data=mean_data,aes(x=Day,y=RelativePerfusion,color=Donor))+
  geom_point()+geom_line()+facet_wrap(~Group)+
  theme(legend.title = element_text(size=8),legend.text=element_text(size=7))+
  ylab("Mean Relative Perfusion")+scale_y_continuous(limits=c(0,1.3),breaks=seq(0,1.3,0.2),expand=c(0,0))+
  scale_x_continuous(limits=c(0,14.5),breaks=seq(0,14.5,1))

## Assignment 2
library(haven)
SkullRats <- read_sav("Datasets/SkullRats.sav")
View(SkullRats)

SkullRats$treat=as.factor(SkullRats$treat)
levels(SkullRats$treat)
levels(SkullRats$treat)<-c("Control","High dose","Low dose")
levels(SkullRats$treat)

ggplot(data=SkullRats,aes(x=age,y=response,color=as.factor(rat)))+
  geom_point()+geom_line()+facet_wrap(~treat)+
  theme(legend.title = element_text(size=8),legend.text=element_text(size=7))+
  ylab("Mean Response in pixels")+scale_y_continuous(limits=c(65,92.5),breaks=seq(65,92.5,5),expand=c(0,0))+
  xlab("Age in days")+scale_x_continuous(limits=c(50,110),breaks=seq(50,110,10))+
  scale_color_discrete(name="Rat")+ggtitle("Treatment")+theme(plot.title = element_text(hjust=0.5,size = 10))

#Create a graph indicating the mean growth of each group (average over the rats)
#We would be first required to find the summary data. i.e. find the mean and the confidence intervals. We have used the dplyr package to previously find the means. 

library(dplyr)
mean_data<-group_by(skullrats,age,treat) %>%
  dplyr::summarise(mean.res=mean(response,na.rm=TRUE),
                   sd.res=sd(response,na.rm = TRUE),
                   n.res=n()) %>%
  mutate(se.res=sd.res/sqrt(n.res),
         LCI=mean.res-qt(0.975,n.res-1)*se.res,
         UCI=mean.res+qt(0.975,n.res-1)*se.res)

View(mean_data)

ggplot(data=mean_data,aes(x=age,y=mean.res,ymin=LCI,ymax=UCI))+
  geom_point()+geom_line()+geom_errorbar(width=3)+facet_wrap(~treat)+
  ylab("Mean Response in pixels")+  scale_y_continuous(limits=c(65,92.5),breaks=seq(65,92.5,5),expand=c(0,0))+
  xlab("Age in days")+scale_x_continuous(limits=c(50,110),breaks=seq(50,110,10))+
  ggtitle("Treatment")+theme(plot.title = element_text(hjust=0.5,size = 10))


plot.theme=theme_bw()+ 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border=element_blank(),
        panel.background =element_blank(),
        axis.line = element_line(colour = "black",size=1),
        plot.title = element_text(hjust=0.5,size = 12,face="bold"),
        axis.title = element_text(size=12,face="bold"),
        axis.text =element_text(size=10,colour = "black",face="bold"),
        legend.title =element_text(size=12),
        legend.text=element_text(size=10),
        legend.position = c(0.8,0.2))

ggplot(data=mean_data,aes(x=age,y=mean.res,ymin=LCI,ymax=UCI,colour=treat))+
  plot.theme+
  geom_point(size=1.5,position=position_dodge(width=3))+
  geom_line(size=1,position=position_dodge(width=3))+
  geom_errorbar(width=3,size=1,position=position_dodge(width=3))+
  ylab("Mean Response in pixels")+  scale_y_continuous(limits=c(65,90),breaks=seq(65,90,5),expand=c(0,0))+
  xlab("Age in days")+ scale_x_continuous(limits=c(40,121),breaks=seq(40,121,10),expand=c(0,0))+
  ggtitle("Rat Skull Development")+
  scale_colour_manual(name=" ",breaks=c("Control","Low dose", "High dose"),
                      values=c("red1","green1","blue1"))
library(rmarkdown)
setwd("C:/Users/Jordache/Google Drive/Radboud University")
render("datavisualisation.Rmd",output_file = "datavisualisationstudentcopy.html")

render("datavisualisation-ANSWERS.Rmd",output_file = "datavisualisationwithANSWERS.html")
