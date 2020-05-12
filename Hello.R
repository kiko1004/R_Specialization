colnames(dd)
tail(dd, 2)
dd[47,]
sum(is.na(dd$Ozone))
bad <- is.na(dd)
dds <- na.omit(dd)
mean(dds$Ozone)
filter <- dds$Ozone > 31
dds <- dds[filter,]
filter <- dds$Temp > 90
dds <- dds[filter,]
mean(dds$Solar.R)
dds <- na.omit(dd)
dds <- dd
filter <- dds$Month == 5
dds <- dds[filter,]
max(dds$Ozone)
