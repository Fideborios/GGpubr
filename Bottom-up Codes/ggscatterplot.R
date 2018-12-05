# Load data
library(ggpubr) 
library(haven)
library(extrafont) ### Extra Fonts :-P 
# font_import() do once
loadfonts(device = "win")
# install.packages('devtools')
devtools::install_github("thomasp85/gganimate")

library(gganimate)


# if there is not package installed 
# install.packages(ggpubr)
surgery   <- read_sav("Data/surgery.sav")
head(surgery)
summary(surgery)

surgery$gender =  factor(surgery$gender, labels = c("Male","Female"))
surgery$place =  factor(surgery$place, labels = c(NA,"Outside regional","Local","Regional"))
surgery$infect=  factor(surgery$infect, labels = c("No","Yes"))
surgery$prematur=  factor(surgery$prematur, labels = c("Premature","Term"))
surgery$surgery=  factor(surgery$surgery, labels = c("Abdominal","Cardiac","Other"))





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
          
          
### With ellipse
ggscatter(data = surgery, x = "birthwt", y = "gestatio", combine = F, merge = T,
          color = "gender",fill = "gender", palette = "lancet", 
          shape = 1, size = 3,point = TRUE, rug = F, 
          title = "Scatterplot of gestational age and birth weight", 
          subtitle = "Faceted by infection information",
          xlab = "Birth weight (in grams)", ylab = "Gestational age",
          facet.by = "infect", panel.labs = list(gender = c("Male", "Female")) , 
          short.panel.labs = TRUE,
          ggtheme = theme_minimal(),
          label = "id", font.label = c(12, "italic"), font.family = "Comic Sans MS",
          ellipse = T, ellipse.level = 0.95, ellipse.type = "norm",ellipse.alpha = 0.3, ellipse.border.remove = T, 
          mean.point = T,mean.point.size = 3, repel = T)
          

### With star 
ggscatter(data = surgery, x = "birthwt", y = "gestatio", combine = F, merge = T,
          color = "gender",fill = "gender", palette = "lancet", 
          shape = 1, size = 3,point = TRUE, rug = F, 
          title = "Scatterplot of gestational age and birth weight", 
          subtitle = "Faceted by infection information",
          xlab = "Birth weight (in grams)", ylab = "Gestational age",
          facet.by = "infect", 
          panel.labs = list(gender = c("Male", "Female")) , 
          short.panel.labs = TRUE,
          ggtheme = theme_minimal() ,
          star.plot = FALSE, star.plot.lty = 1, star.plot.lwd = NULL,
          label = "id", font.label = c(12, "italic"), font.family = "Comic Sans MS",
          ellipse = T, ellipse.level = 0.95, ellipse.type = "norm", repel = T)









