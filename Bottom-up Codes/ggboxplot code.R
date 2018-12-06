# Load data
library(ggpubr) 
library(haven)

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

# Basic plot

ggboxplot(surgery, x = "gender", y = "birthwt")

##### Select and order items

# Select only males
ggboxplot(surgery, "gender", "birthwt",select = "Male")

# Change the default order of items
ggboxplot(surgery, "gender", "birthwt",order = c("Female", "Male"))

# put some x-axis and y-axis labels other than the name of the variables
ggboxplot(surgery, x = "gender", y = "birthwt",xlab = "Gender", 
          ylab = "Birth Weight (in grams)")

# put a title over the graph
ggboxplot(surgery, x = "gender", y = "birthwt",
          xlab = "Gender", ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ")


# width: change box plots width to a half (0.5)
ggboxplot(surgery, x = "gender", y = "birthwt",xlab = "Gender", ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", width = 0.5)

# Change orientation: horizontal
ggboxplot(surgery, "gender", y = "birthwt",xlab = "Gender", ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", width = 0.5, orientation = "horizontal")

# Notched box plot
ggboxplot(surgery, x = "gender", y = "birthwt",xlab = "Gender", ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", width = 0.5,notch = TRUE)

# Add dots
# ++++++++++++++++++++++++++
ggboxplot(surgery, x = "gender", y = "birthwt",xlab = "Gender", ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", width = 0.5,add = "dotplot")

# Add jitter points and change the shape by Gender
# An artificial noise is the points is introduced to make the graph look better
# otherwise the values would in straight line (for males and females)
ggboxplot(surgery, x = "gender", y = "birthwt",xlab = "Gender", ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", width = 0.5,add = "jitter", 
          shape = "gender")


# Change colors
# +++++++++++++++++++++++++++
# Change outline and fill colors
ggboxplot(surgery, "gender", y ="birthwt",xlab = "Gender", ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", width = 0.5,add = "jitter", 
          shape = "gender", color = "purple", fill = "gray")

# Change outline colors by groups: gender
# Use custom color palette
# Add jitter points and change the shape by groups
ggboxplot(surgery, "gender", "birthwt",xlab = "Gender", 
          ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", 
          width = 0.5,add = "jitter", 
          shape = "gender",color = "gender", 
          palette =c("#00AFBB", "#E7B800"), 
          shape = "gender")

## Use a predined palette
## You can automatically pick colors from 2 color palette packages
## brewer and ggsci
## see the help file

ggboxplot(surgery, "gender", "birthwt",xlab = "Gender", 
          ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", 
          width = 0.5,add = "jitter", 
          shape = "gender",color = "gender", 
          palette = "Dark2", 
          shape = "gender")


# Change fill the boxes with color by groups: gender
ggboxplot(surgery, "gender", "birthwt",xlab = "Gender", 
          ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", 
          width = 0.5,add = "jitter", 
          shape = "gender",fill = "gender", 
          palette = "simpsons", 
          shape = "gender")

# Box plot with multiple groups
# +++++++++++++++++++++
# fill or color box plot by a second group : "infect"
ggboxplot(surgery, "gender", "birthwt",xlab = "Gender", 
          ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ",
          subtitle = "Splitted over infected (Yes/No)",
          width = 0.5,add = "jitter", 
          shape = "gender",
          color = "infect",
          palette = "simpsons", 
          shape = "gender" 
          )


# We change the transparency of the bars with alpha = 0.2 
ggboxplot(surgery, "gender", "birthwt",xlab = "Gender", 
          ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", 
          width = 0.5,add = "jitter", 
          shape = "gender",
          fill = "gender",
          palette = "simpsons", 
          shape = "gender",alpha =0.2 
)

# Let's make facet by "infect" a variable the boxplots

ggboxplot(surgery, "gender", "birthwt",xlab = "Gender", 
          ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ",
          subtitle = "Splitted over infected (Yes/No)",
          width = 0.5,add = "jitter", 
          shape = "gender",
          color = "infect",
          palette = "simpsons", 
          shape = "gender", facet.by = "infect"
)



######################################################
# ggboxplot is compatible with the options of ggpar()#
# see help file of ggpar, aka Graphical parameters   #
######################################################

#### Change position, the font and title of the legend
ggboxplot(surgery, "gender", "birthwt",xlab = "Gender", 
          ylab = "Birth Weight (in grams)",
          title = "Boxplot of weight at birth ", 
          width = 0.5,add = "jitter", 
          shape = "gender",
          fill = "gender",
          palette = "simpsons", 
          shape = "gender",
          legend = "bottom",
          legend.title="Gender",
          font.legend = c(10, "bold", "grey")
)


#### Play with the Title and subtitle of the plot

ggboxplot(data = surgery,x =  "gender", y = "birthwt",
          xlab = "Gender", ylab = "Birth Weight (in grams)",
          width = 0.5,add = "jitter", 
          shape = "gender",fill = "gender",palette = "simpsons", 
          legend = "bottom",legend.title="Gender",font.legend = c(10, "bold", "grey"),
          title = "A boxplot of weight on birth",  font.main = c(18, "italic", "black"),
          subtitle = "Male and female infants compared ", font.subtitle = c(12, "bold.italic", "darkgreen")
)

#### Or we can use an already existent theme 

ggboxplot(data = surgery,x =  "gender", y = "birthwt",
          xlab = "Gender", ylab = "Birth Weight (in grams)",
          width = 0.5,add = "jitter", 
          shape = "gender",fill = "gender",palette = "simpsons", 
          legend = "bottom",legend.title="Gender",font.legend = c(10, "bold", "darkgrey"),
          title = "A boxplot of weight at the time of birth",  font.main = c(18, "italic", "black"),
          subtitle = "Male and female infants compared ", font.subtitle = c(12, "bold.italic", "darkgreen"),
          ggtheme = theme_minimal()
          )


### It's ggplot2 object so you can fill it with more things

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
  stat_compare_means(method = "t.test")#  Add a p-value

