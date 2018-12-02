library(ggpubr)
install.packages("tidyverse")
library(MASS)


Sigma= matrix(c(10,0.5,0.5,15), 2)
Sigma2= matrix(c(7.5,0.5,0.5,7.5), 2)


df =  data.frame(mvrnorm(1000,c(180,80) , Sigma = Sigma) , Gender = rep("Male"))
df2 =  data.frame(mvrnorm(400,c(170,65) , Sigma = Sigma2) , Gender = rep("Female"))

df = rbind(df, df2)
names(df) = c("Height","Weight","Gender")





## How to make a histogram

gghistogram(data = df ,x =  "Height", 
            y = "..count..",bins = 25, fill = "Gender",
            palette = "lancet",ggtheme = theme_bw(), 
            title = "This is an example of a Histogram", 
            add = "mean",add_density = T,label.rectangle = T) + 
  theme(plot.title = element_text(hjust = 0.5))

## How to make a boxplot 

ggboxplot(data = df ,x =  "Gender", 
            y = "Height",fill = "Gender",
            palette = "lancet",
          ggtheme = theme_bw(), 
            title = "This is an example of a Boxplot", 
          bxp.errorbar = T, add = "median_ci") + 
  theme(plot.title = element_text(hjust = 0.5))+  # Add pairwise comparisons p-value
  stat_compare_means(label.y = 165,label.x = 0.75)                  # Add global p-value


# Mean +/- standard deviation
ggerrorplot(df, 
            y = "Height",  
            x= "Gender", 
            desc_stat = "mean_sd")



# Scatter-plot 

ggscatter(df , "X1", "X2",color = "lightgray")



# Basic bar plots with label
p <- ggbarplot(df, x = "Nationality", y = "frequency",
               color = "black", fill = "lightgray")
p

df$Nationality =  as.factor(df$Nationality)

ggbarplot(df, x = "Nationality", y = "frequency",
          color = "Nationality", fill = "Nationality", palette = "jco")



# Rotate to create horizontal bar plots
p + rotate()
