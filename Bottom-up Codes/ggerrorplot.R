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
skullrats$t

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
  ggtitle("Rat Skull Development")+
  scale_colour_manual(name=" ",breaks=c("Control","Low dose", "High dose"),
                      values=c("red1","green1","blue1")) + theme_minimal() + theme(plot.title =element_text(hjust= 0.5))



View(bar_error)

ggplot(data=bar_error,aes(x=age,y=mean.response,ymin=LCI,ymax=UCI))+
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

ggplot(data=bar_error,aes(x=age,y=mean.response,ymin=LCI,ymax=UCI,colour=treat))+
  plot.theme+
  geom_point(size=1.5,position=position_dodge(width=3))+
  geom_line(size=1,position=position_dodge(width=3))+
  geom_errorbar(width=3,size=1,position=position_dodge(width=3))+
  ylab("Mean Response in pixels")+  scale_y_continuous(limits=c(65,90),breaks=seq(65,90,5),expand=c(0,0))+
  xlab("Age in days")+ scale_x_continuous(limits=c(40,121),breaks=seq(40,121,10),expand=c(0,0))+
  ggtitle("Rat Skull Development")+
  scale_colour_manual(name=" ",breaks=c("Control","Low dose", "High dose"),
                      values=c("red1","green1","blue1"))


ggplot(data=bar_error,aes(x=age,y=mean.response,ymin=LCI,ymax=UCI,colour=treat))+
  geom_point(size=1.5,position=position_dodge(width=3))+
  geom_line(size=1,position=position_dodge(width=3))+
  geom_errorbar(width=3,size=1,position=position_dodge(width=3))+
  ylab("Mean Response in pixels")+  scale_y_continuous(limits=c(65,90),breaks=seq(65,90,5),expand=c(0,0))+
  xlab("Age in days")+ scale_x_continuous(limits=c(40,121),breaks=seq(40,121,10),expand=c(0,0))+
  ggtitle("Rat Skull Development")+
  scale_colour_manual(name=" ",breaks=c("Control","Low dose", "High dose"),
                      values=c("red1","green1","blue1")) + theme_minimal() + theme(plot.title =element_text(hjust= 0.5))
