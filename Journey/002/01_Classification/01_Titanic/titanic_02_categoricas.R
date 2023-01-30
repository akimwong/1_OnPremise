#-----------------
# Autor: Carlos Wong
# Fecha: 2022_11_17
# Input: Datos de entrada de Titanic.
# Salidas: Submission - Graficos - Analisis
# Cambios: Esdtudiar categoricas - Modelo con categoricas
#-----------------

install.packages("Rcpp")
install.packages("data.table")
install.packages("dplyr")
install.packages("forcats")
install.packages("ggplot2")
install.packages("lubridate")
install.packages("stringr")
install.packages("inspectdf")
install.packages("ranger")
install.packages("tictoc")
install.packages("mice")
install.packages("forcats")

setwd('C:/MBD/18_BD_E')


#---- Carga de librerias 
suppressPackageStartupMessages({
  library(data.table)    # Data Manipulation
  library(dplyr)         # Data Manipulation - RStudio
  library(forcats)       # Tratamiento de factores
  library(ggplot2)       # Graficos ggplot
  library(inspectdf)     # EDA autom√°ticos Gr√°ficos
  library(lubridate)     # Manipulaci√≥n Fechas
  library(ranger)        # randomForest en C++ muy r√°pido.
  library(stringr)       # Manipulaci√≥n Strings
  library(tictoc)        # Medida tiempos de ejecuci√≥n
})

library(data.table)    # Data Manipulation
library(dplyr)         # Data Manipulation - RStudio
library(forcats)       # Tratamiento de factores
library(ggplot2)       # Graficos ggplot
library(inspectdf)     # EDA autom√°ticos Gr√°ficos
library(lubridate)     # Manipulaci√≥n Fechas
library(ranger)        # randomForest en C++ muy r√°pido.
library(stringr)       # Manipulaci√≥n Strings
library(tictoc)        # Medida tiempos de ejecuci√≥n
library(mice)          # imputation

#---- Carga de librerias 
suppressPackageStartupMessages({
  library(data.table)    # Data Manipulation
  library(dplyr)         # Data Manipulation - RStudio
  library(tictoc)        # Mesure of execution times
  library(lubridate)     # Date manipulation
  library(stringr)       # String manipulation
  library(inspectdf)     # Automatic EDA
  library(ranger)        # Fast RandomForest
  library(ggplot2)       # ggplot graphics
  library(forcats)       # Factor treatment
  library(missRanger)    # Imputation of NAs using ranger
  library(forcats)       # tratamiento de factores
})

getwd()
setwd("C://Users//Carlos//0_OnPremise//GitHub//01_Titanic//titanic_R")

#---- upload data
# We are going to use fread function from data.table package
tic()
trainOri   <- as.data.frame(fread("./dataset/train.csv"))
testOri    <- fread("./dataset/test.csv", data.table = FALSE)
submission  <- fread("./dataset/gender_submission.csv", data.table = FALSE)
toc()

#---- EDA (Exploratory Data Analysis)
# Horizontal bar plot for categorical column composition
#x <- inspect_cat(trainOri) 
#show_plot(x)

# Correlation betwee numeric columns + confidence intervals
#x <- inspect_cor(trainOri)
#show_plot(x)

# Bar plot of most frequent category for each categorical column
#x <- inspect_imb(trainOri)
#show_plot(x)

# Bar plot showing memory usage for each column
#x <- inspect_mem(trainOri)
#show_plot(x)

# Occurence of NAs in each column ranked in descending order
#x <- inspect_na(trainOri)
#show_plot(x)

# Histograms for numeric columns
#x <- inspect_num(trainOri)
#show_plot(x)

# Barplot of column types
#x <- inspect_types(trainOri)
#show_plot(x)

# Correlation between numeric columns + confidence intervals
#x <- inspect_cor(trainOri)
#x_coralta <- x %>% filter(corr > 0.25)
#show_plot(x_coralta)

# Otro tipo de .head()
#glimpse(trainOri)

# --------------------------------------------
# ------- Age Missings Imputation (mice)

# Make variables factors into factors
factor_vars <- c('Pclass','Sex','Embarked')

trainOri[factor_vars] <- lapply(trainOri[factor_vars], function(x) as.factor(x))
# Set a random seed
set.seed(129)
# Perform mice imputation, excluding certain less-than-useful variables:
mice_mod <- mice(trainOri[, !names(trainOri) %in% c('Name','Ticket','Cabin','Survived')], method='rf') 

mice_output <- complete(mice_mod)

# Plot age distributions
par(mfrow=c(1,2))
hist(trainOri$Age, freq=F, main='Age: Original Data', 
     col='darkgreen', ylim=c(0,0.04))
hist(mice_output$Age, freq=F, main='Age: MICE Output', 
     col='lightgreen', ylim=c(0,0.04))

# Replace Age variable from the mice model.
trainOri$Age <- mice_output$Age

# Show new number of missing Age values
sum(is.na(trainOri$Age))

# --- NUEVO: CategÛricas - Niveles de cada variable categÛrica

x <- inspect_cat(trainOri)
show_plot(x)

trainCat <- trainOri %>% select(where(is.character))

# funciÛn extracciÛn de valores distintos por categÛrica
myfun <- function(x) {
  num_lev <- length(unique(x))
  return(num_lev)
}     
# nombres de columnas ilegibles
numlev_df <- as.data.frame(apply(trainCat,2,myfun))  
# cambio de nombres de columnas
numlev_cl <- data.frame(
  cols = rownames(numlev_df),
  freq = numlev_df[,1]
)
# ordena de mayor a menor
numlev_end <- numlev_cl %>% arrange(desc(-freq))   

# Umbral para seleccionar categoricas en funciÛn de la cantidad de valores distintos 
lev_sel <- 700

# filtra variables de acuerdo al umbral pre establecido y a cualquier nombre especÌfico
# quito 'Ticket'
col_val <- numlev_end %>%
  filter(freq <= lev_sel, cols != 'Ticket') %>%
  select(cols)

# No usarÈ col_val al ser el dataset muy pequeÒo
features = c('Pclass','Sex')

trainCatRed <- trainOri[, c(features)]

# ----- Modelo Variables Numericas ----------
# conjunto train
trainNum <- trainOri %>% select(where(is.numeric))
trainNum$Survived <- as.factor(trainNum$Survived)

# --- Quito Id
trainNumNoId <- trainNum %>% select (-PassengerId)

# Junto las variables numÈricas con las categÛricas
trainNumCat <- cbind(trainNumNoId,trainCatRed)
trainNumCat$Survived <- as.factor(trainNumCat$Survived)

# conjunto test
testNum <- testOri %>% select(where(is.numeric))

# ----------------------------
# ------- Modelo -------------

# randomForest (ranger)

mymodel <- ranger(Survived ~.,
                  data = trainNumCat,
                  importance = 'impurity',
                  num.trees = 600)

# medida del error 'local' intrinseca a trainOri
mymodel_err <- 1 - mymodel$prediction.error
mymodel_err

var_imp <- as.data.frame(mymodel$variable.importance)
var_imp_df <- data.frame(
  var = rownames(var_imp),
  imp = var_imp[,1]
) %>% arrange(desc(imp))
var_imp_df

# Gr·fico de variables importantes

var_imp_df %>% ggplot(aes(y=imp, x = fct_reorder(as.factor(var), imp))) +
  geom_col(group = 1, fill = 'darkred') +
  coord_flip() +
  theme_bw()

ggsave('./charts/titanic_02_3numvarsNoId3catvar.png')

# -----------------------------
# PredicciÛn
# -----------------------------

# ------- Fare Missings Imputation 
which(is.na(testOri$Fare), arr.ind=TRUE)

testOri$Fare[153] <- median(testOri[
  testOri$Pclass == '3' 
  & testOri$Embarked == 'S', ]$ Fare, na.rm = TRUE)

# Show new number of missing Age values
sum(is.na(testOri$Fare))

testOri$Fare

# ------- Age Missings Imputation (mice)

# Make variables factors into factors
factor_vars <- c('Pclass','Sex','Embarked')

testOri[factor_vars] <- lapply(testOri[factor_vars], function(x) as.factor(x))
# Set a random seed
set.seed(129)
# Perform mice imputation, excluding certain less-than-useful variables:
mice_mod <- mice(testOri[, !names(testOri) %in% c('Name','Ticket','Cabin','Survived')], method='rf') 

mice_output <- complete(mice_mod)

# Plot age distributions
par(mfrow=c(1,2))
hist(testOri$Age, freq=F, main='Age: Original Data', 
     col='darkgreen', ylim=c(0,0.04))
hist(mice_output$Age, freq=F, main='Age: MICE Output', 
     col='lightgreen', ylim=c(0,0.04))

# Replace Age variable from the mice model.
testOri$Age <- mice_output$Age

# Show new number of missing Age values
sum(is.na(testOri$Age))


mypred <- predict(mymodel, testOri)$predictions
mysubm <- data.table(
  PassengerId = testOri$PassengerId,
  Survived = mypred
)
mysubm

fwrite(mysubm,'./submission/titanic_02_3numvarsNoId3catvar_600trees.csv')

## Resultados

# titanic_00.R - ranger 600 trees numeric 0.7037037 Kaggle: 0.67224
# titanic_01.R - ranger 600 trees numeric NoId 0.694725 Kaggle: 0.66507
# titanic_02.R - ranger 600 trees Numeric Categ('Pclass','Sex','Embarked') 0.8215488 Kaggle: 0.7799