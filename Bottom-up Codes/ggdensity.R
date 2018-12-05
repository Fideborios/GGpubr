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


# Basic Density plot 
ggdensity(surgery, x = "birthwt")



# put a title over the graph
ggdensity(surgery, x = "birthwt",
            xlab = "Weight at birth (in grams)", ylab = "Count",
            title = "Density plot of infant weight at birth")

# Add a vertical line on the median (or mean)

ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth")


# Change colors
# +++++++++++++++++++++++++++
# Change outline and fill colors

ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth", color = "purple", fill = "gray")


# Change outline colors by groups: gender
# Use custom color palette

ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth", color = "gender",
            palette =c("#00AFBB", "#E7B800") )


## Use a predined palette
## You can automatically pick colors from 2 color palette packages
## brewer and ggsci
## see the help file

ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth", color = "gender",
            palette = "Dark2" )

# Change fill the boxes with color by groups: gender


ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth",fill = "gender",
            palette = "lancet",
            color = "grey" )

# We change the transparency of the bars with alpha = 0.2 

ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth",fill = "gender",
            color = "grey",palette = "lancet",
            alpha = 0.2  )

# Let's make 2 Density plot ofs by "infect" a variable the boxplots

ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth",fill = "gender",
            color = "grey",palette = "lancet",alpha = 0.2, 
            facet.by = "infect" )



########################################################
# ggdensity is compatible with the options of ggpar()#
# see help file of ggpar, aka Graphical parameters   ###
########################################################

#### Change position, the font and title of the legend

ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth",fill = "gender",
            color = "grey",palette = "lancet",alpha = 0.2,
            legend = "bottom",legend.title="Gender",
            font.legend = c(10, "bold", "darkgrey") )

#### Play with the Title and subtitle of the plot

ggdensity(surgery, x = "birthwt",add = "median",
            xlab = "Weight at birth (in grams)", ylab = "Frequency",
            title = "Density plot of infant weight at birth",
            fill = "gender",color = "grey",palette = "lancet",
            alpha = 0.2,legend = "bottom",legend.title="Gender",
            font.legend = c(10, "bold", "darkgrey"), facet.by = "infect", ggtheme = theme_minimal() )+   
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))
