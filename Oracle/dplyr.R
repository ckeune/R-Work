#################
#Data management#
#################

##Install Packages:


required_libraries <- c('ggplot2',
                        'stringr',
                        'lubridate',
                        'dplyr',
                        'scales',
                        'magrittr', 
                        'lattice',
                        'dplyr',
                        'plyr',
                        'lubridate')

#Install/load required libraries
for (lib_name in required_libraries){
  if (!require(lib_name, character.only = T)) 
    install.packages(lib_name)
  library(lib_name, character.only = T)
}


#the data frame I will use
data<-data.frame(Factor1=rep(LETTERS[1:5],each=20),Factor2=sample(letters[1:10],100,replace=TRUE),Var1=rnorm(100,2,4),Var2=rpois(100,2))
#some simple summary
summary(data)
table(data$Factor1)
table(data$Factor2)

#####basic way using vectors######
#subsetting
#only keep observation with Factor1 equal to A
sub1<-subset(data,Factor1=="A")
#only keep observation with Factor1 equal to A and Var2 lower than 4
data$Factor1=="A"
sub2<-data[data$Factor1=="A" & data$Var2<4,]
summary(sub2)
#only keep every thrird rows
head(data[seq(1,nrow(data),3),])
#only keep row number 2,6,13,22 from column 1 and 4
data[c language="(2,6,13,22),c(1,4)"][/c] #when numbers are following each other can use :, ie 1:10

#summarising
#library(plyr)
#get the mean value and standard error of Var1 for each level of Factor1
sub3 <- rbind.fill(by(data,data$Factor1,function(x) return(data.frame(Factor1=unique(x$Factor1),Mean=mean(x$Var1),SE=sd(x$Var1)/sqrt(length(x$Var1))))))
#get the 25% and 75% quantile for Var2 for each level of Factor2
sub4 <- rbind.fill(by(data,data$Factor2,function(x) return(data.frame(Factor2=unique(x$Factor2),Q_25=quantile(x$Var2,prob=0.25),Q_75=quantile(x$Var2,prob=0.75)))))

#changing column order
data<-data[,c(1,4,3,2)]
head(data)
#also work with column names
data<-data[,c("Factor1","Var1","Factor2","Var2")]
head(data)
#sorting the rows first by Factor1 then by Factor2
data<-data[do.call(order,list(data$Factor1,data$Factor2)),]

######increasing complexity, switching from long to wide format########
library(reshape2)
#the long format makes one column keeping the info on a grouping variable (eg Sex) instead of making a separate column for each levels
#the object data is for example in a long format, we may want to make a separate column for each level of Factor1 and storing Var1 in the rows
data$Observation<-rep(1:20,time=5)
data_wide<-dcast(Observation~Factor1,data = data,value.var = "Var1")
#the left-hand side of the formula is the variable that will make up the rows the right hand side the columns
#if certain combination are missing one can use the fill argument
data_wide2 <-dcast(Factor2~Factor1,data=data,fun.aggregate = length,fill=0) #here we count how many observations are for each levels of Factor2 and Factor1
#other functions can be provided if nore then one values are present in each cells
data_wide<-dcast(Factor2~Factor1,data=data,fun.aggregate = sum,value.var="Var2",fill=0)
#turning back the data to a long format
data_long<-melt(data_wide,value.name = "Sum_Var2",id.vars="Factor2",variable.name = "Factor1") #melt the data frame id.vars correspond to the column that contain the factor infos
#long format are then pretty handy to use for plotting
library(ggplot2)
ggplot(data_long,aes(x=Factor2,y=Sum_Var2,colour=Factor1))+geom_point()
#but is also the way the data should be structure for data analysis:
lm(Sum_Var2~Factor2+Factor1,data_long)



####using the dplyr to turn all data manipulation easy######
library(dplyr)
library(plyr)
#the five functions of dplyr, dplyr works with data frame instead of vectors which makes data frame manipulation much more straightforward
test <- filter(data,Factor1%in%c("A","D"),Var1>=0) #similar to subset
head(select(data,contains("factor",ignore.case=TRUE))) #only return some specific columns see ?select for more possibilities
head(arrange(data,Factor1,Var1))
head(mutate(data,Var3=Var1+Var2,M_1=(Observation+Var2)/length(Var2)))
summarise(data,sum(Var2))
#summarise becomes extremely handy when use with group_by
data_d2<-summarise(group_by(data,Factor2),Mean=mean(Var1),SE=sd(Var1)/sqrt(n())) #remember the huge by function needed to get the same results
#the n() function is built-in with dplyr and count how many element there are
#going from the full dataset to a graph summarising mean difference between factor is swift and painless using these functions
ggplot(data_d,aes(x=Factor1,y=Mean))+geom_point(colour="red",size=3,show_guide=FALSE)+geom_errorbar(aes(ymin=Mean-2*SE,ymax=Mean+2*SE),width=.1)
