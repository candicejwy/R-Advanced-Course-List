util <- read.csv("P3-Machine-Utilization.csv")
head(util,12)
str(util)
summary(util)
util$Utilization <- 1-util$Percent.Idle
head(util,12)
#Handling Date-Time in R:
tail(util)
util$PosixTime <- as.POSIXct(util$Timestamp,format="%d/%m/%Y %H:%M")
head(util,12)
summary(util)
#Tip: rearrange column in a df:
util$Timestamp <- NULL
head(util,12)
#What is a List?
RL1 <- util[util$Machine=="RL1",]#subset of data
summary(RL1)
#counstruct List: max,min, mean
util_stats_rl1 <- c(min(RL1$Utilization,na.rm = T),
                    mean(RL1$Utilization,na.rm = T),
                    max(RL1$Utilization,na.rm = T))
util_stats_rl1

util_under_90 <- which(RL1$Utilization<0.90) #which element are True
util_under_90

util_under_90_flag <- length(which(RL1$Utilization<0.90))
util_under_90_flag

list_rl1 <- list("RL1",util_stats_rl1, util_under_90_flag)
list_rl1
#Naming component of list:
names(list_rl1) <- c("Machine","Stats","LowThreshold")
names(list_rl1)
#another way: like with df:
rm(list_rl1)
list_rl1
list_rl1 <- list(Machine = "RL1",Stats = util_stats_rl1,
                 LowTHreshold = util_under_90_flag)
list_rl1
#Extracting component list:
list_rl1[1]
list_rl1[2]
list_rl1$Machine
typeof(list_rl1[[2]])
typeof(list_rl1[2])
list_rl1$Stats
typeof(list_rl1$Stats)
#access the 3rd element of vector?
list_rl1[[2]][3]
list_rl1$Stats[3]
#Adding & deleting components:
list_rl1[7] <- "New Info"
list_rl1[4] <- NULL
list_rl1
length(list_rl1)
list_rl1[4:6] <- NULL
list_rl1
#Another way via $
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1
#!Notice: numerations has shifted
#different from dataframe, not a structure
#Add another component
#Dataframe for this machine
list_rl1$Data <- RL1
list_rl1
summary(list_rl1)
str(list_rl1)
#Subseting a list:
list_rl1[1:2] #return a list contains 2 conponents
list_rl1[c(1,4)] #return 1 & 4th conponents
sublist_rl1 <- list_rl1[c("Machine","Stats")]
sublist_rl1
sublist_rl1[[2]][2]
sublist_rl1$Stats[2]
#[[]]-not for subsetting but for accessing,[]-for subsetting
#Creating Time Series Plot:
library(ggplot2)
p <- ggplot(data = util)
myplot <- p+geom_line(aes(x = PosixTime, y = Utilization,color = Machine,size = 0.4))+
facet_grid(Machine~.)+
  geom_hline(yintercept = 0.9,colour="black",linetype = 3)
list_rl1$myplot <- myplot
list_rl1
summary(list_rl1)

