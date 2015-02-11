# set seed in order to replicate

set.seed(362013)
#create structure for choice data
choice<-NULL

#simulates 100 respondents and 9 choice sets
for (i in 1:100) {
  cell1<-NULL
  cell2<-NULL
  cell3<-NULL
  cell4<-NULL
  cell5<-NULL
  cell6<-NULL
  cell7<-NULL
  cell8<-NULL
  cell9<-NULL
  
  cell1<-rbind(cell1,which.max(rmultinom(1, size = 1, prob = c(0.5,0.3,0.2))))
  cell2<-rbind(cell2,which.max(rmultinom(1, size = 1, prob = c(0.5,0.2,0.3))))
  cell3<-rbind(cell3,which.max(rmultinom(1, size = 1, prob = c(0.5,0.1,0.4))))
  cell4<-rbind(cell4,which.max(rmultinom(1, size = 1, prob = c(0.4,0.3,0.3))))
  cell5<-rbind(cell5,which.max(rmultinom(1, size = 1, prob = c(0.4,0.2,0.4))))
  cell6<-rbind(cell6,which.max(rmultinom(1, size = 1, prob = c(0.4,0.1,0.5))))
  cell7<-rbind(cell7,which.max(rmultinom(1, size = 1, prob = c(0.3,0.3,0.4))))
  cell8<-rbind(cell8,which.max(rmultinom(1, size = 1, prob = c(0.3,0.2,0.5))))
  cell9<-rbind(cell9,which.max(rmultinom(1, size = 1, prob = c(0.3,0.1,0.6))))
  
  row<-cbind(cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9)
  choice<-rbind(choice,row)
}
 

table(choice)
apply(choice,2,table) 
choice_df<-data.frame(cbind(1:100,choice))
names(choice_df)<-c("id","set1","set2","set3","set4","set5","set6","set7","set8","set9")

choice_df