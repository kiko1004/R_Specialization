#Import data --------------------
library(readr)
st9572_2017 <- read_csv("st9572_2017.csv")
st9572_2018 <- read_csv("st9572_2018.csv")
weather <- read_csv("weather.csv")

#Format ------------------
st9572_2017 <- st9572_2017[,-1]
st9572_2018 <- st9572_2018[,-1]
sapply(st9572_2017, class)
sapply(st9572_2018, class)
#Min/max
min(st9572_2017$time)
max(st9572_2017$time)
min(st9572_2018$time)
max(st9572_2018$time)
#Duplicates check
sum(duplicated(st9572_2017$time))
sum(duplicated(st9572_2018$time))
#Binding
library(dplyr)
st9572=bind_rows(st9572_2017,st9572_2018)
min(st9572$time)
max(st9572$time)
sum(duplicated(st9572$time))
#Generate Date
library(lubridate)
st9572$date=date(st9572$time)
weather$date=make_date(year=weather$year,month=weather$Month,day=weather$day)
sum(duplicated(weather$date))
# Aggregate data
st9572A=st9572 %>% 
  group_by(date) %>% 
  summarise(PM=mean(P1eu,na.rm=T))
# Join
st9572A=left_join(st9572A,weather[,-c(1:3)],by="date")
#Check
summary(st9572A)
colSums(is.na(st9572A))
#Clean
#st9572AS <- na.omit(st9572A)
aux=c("PRCPMAX","PRCPMIN","VISIB")
st9572A=st9572A[,!names(st9572A) %in% aux]
#Deal with missing values
install.packages("imputeTS")
library(imputeTS)
st9572A[,-1]=sapply(st9572A[,-1],na_interpolation,option="linear")
rm(st9572, st9572_2017, st9572_2018)
rm(aux)
save.image("st9572.RData")
write.csv(st9572A, "st9572A.csv" )
# Question answers -----------------------
attach(st9572A)
library(corrplot)
M<-cor(st9572A[,-1])
corrplot(M, method="pie")

I = cor(st9572A[,c(3:8)])
corrplot(I, method="number")
library(knitr)
knit('Kiril_Spiridonov_2733_Case_Study_1.Rmd', encoding = 'UTF-8')

