######################################################################
# BATTERY SWITCHING MODEL - BASIC
######################################################################

suppressWarnings(suppressMessages({
  library(dplyr)
  library(dbplyr)
  library(data.table)
  library(reshape2) # for melt function
  library(lubridate) # dates and times
  library(ggplot2)
  library(zoo) # for interpolation function
}))

DT<-read.csv('Z:/Temp Data/nswprices2022.csv')
DT<-as.data.table(DT)
DT[, DATETIME := mdy_hms(DT[["DATETIME"]])]
DT$Price<-DT$FCST
str(DT)

# params
rdrate<-0.416666667
maxDOD<-0.9999
startSOC<-29.605
DODlimit<-(1-maxDOD)*startSOC
lprice<-70
uprice<-130

##### Establish simulation
DT[c(1),SOC:=startSOC]
DT[c(1),DODlimiter:=ifelse(startSOC>DODlimit,1,0)] # do not discharge below DOD limit
DT[c(1),CHlimiter:=ifelse(SOC<startSOC,1,0)] # do not charge above max charge
DT[c(1),charge:=ifelse((Price<lprice & CHlimiter==1),-rdrate,0)] # charge
DT[c(1),discharge:=ifelse((Price>uprice & DODlimiter==1),rdrate,0)] # discharge
DT[c(1),revenue:=0]
DT[c(1),cost:=0]
DT[c(1),profit:=0]

# loop the path dependency
for (i in 2:nrow(DT[X<1000,])){ # just look at the first 1000 rows
  DT$SOC[i]<-DT$SOC[i-1]+DT$charge[i-1]-DT$discharge[i-1]
  DT$DODlimiter[i]<-ifelse(DT$SOC[i]>DODlimit,1,0) # do not charge, at 0% limit
  DT$CHlimiter[i]<-ifelse(DT$SOC[i]<startSOC,1,0) # do not charge above max 100% limit
  DT$charge[i]<-ifelse((DT$Price[i]<lprice & DT$CHlimiter[i]==1),rdrate,0)
  DT$discharge[i]<-ifelse((DT$Price[i]>uprice & DT$DODlimiter[i]==1),rdrate,0)
}

DT$revenue<-DT$Price*DT$discharge
DT$cost<-DT$Price*DT$charge
DT$profit<-DT$revenue-DT$cost
DT$CumProfit<-cumsum(DT$profit)

# Evaluate profit
sum(DT[X<1000,]$profit)

# Evaluate cycles per day
# days
days<-nrow(DT[X<1000,])/12/24
days
(sum(DT[X<1000,]$charge)+sum(DT[X<1000,]$discharge))/rdrate/12/days

plot(DT[X<1000,]$DATETIME,DT[X<1000,]$CumProfit,type="l", xlab="Time", ylab="$", main="Profit")
plot(DT[X<1000,]$DATETIME,DT[X<1000,]$SOC,type="l", xlab="Time", ylab="MW", main="Charge")
