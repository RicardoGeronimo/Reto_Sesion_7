# Instalo los paquetes
install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")

# Llamo los paquetes
library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)

# Conecto la BD
MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

# Listo las tablas de la BD
dbListTables(MyDataBase)

# Listo los campos de la tabla que contiene el idioma
dbListFields(MyDataBase, 'CountryLanguage')

# Hago el query sobre la tabla
DataDB <- dbGetQuery(MyDataBase, "SELECT * FROM CountryLanguage")

# Muestro los nombres de mi query
names(DataDB)

SP <- DataDB %>% filter(Language == "Spanish")

SP.df <- as.data.frame(SP)

SP.df %>% ggplot(aes( x = CountryCode, y=Percentage, color = IsOfficial )) + 
  geom_point() +
  coord_flip()
