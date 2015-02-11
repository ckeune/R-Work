# 
# 
# required_libraries <- c('reshape2',
#                         'stringr',
#                         'dplyr',
#                         'scales',
#                         'RODBC',
#                         'PF')
# 
# 
# for (lib_name in required_libraries){
#   if (!require(lib_name, character.only = T)) 
#     install.packages(lib_name)
#   library(lib_name, character.only = T)
# } 
setwd("~/shared")
source("RRscDF.R")

library("ROracle")
drv <- dbDriver("Oracle")


#input the table name here
table_name <- "DS_20141028_RST_0ZV157LCHOGDG"

#insert column names of test cells
gtest <- g[, c("CONTROL"     ,   "TOTAL_CONTROL" , "EXPOSED"   ,     "TOTAL_EXPOSED" )]

#insert confidence intervals
conf <- c(.95,.9,.8)

#input db or data link info here(either olive or analystdb)
database_name <- "analystdb"

#build strings
#tbl <- paste(table_name, database_name , sep ="@")

sqlc <- paste("select * from ", table_name) #sep = "")
#connection to analyst
con <- dbConnect(drv, "analyst", "2m442D", "localhost:1521/ffmis02.internal.essence.co.uk")
#connection to olive
#con <-odbcConnect("Olive11", uid="olive", pwd="olive_tr33s")
#sqlSave(con, test_table, "TEST_TABLE")

g <- dbGetQuery(con, sqlc)

#g <- sqlQuery(con,  sqlc)
#d <- sqlQuery(con, "select * from TEST_TABLE")
#close(con)


#con <- dbConnect(drv, "analyst", "2m442D", "localhost:1521/ffmis02.internal.essence.co.uk")

#res <- dbGetQuery(con, "SELECT clt_id, clt_name FROM olive.mktg_clients@READONLY_FFMIS01.INTERNAL.ESSENCE.CO.UK")






## START MATH

g$c_acct_rate <- Map("/", g$CONTROL, g$TOTAL_CONTROL)
g$e_acct_rate <- Map("/", g$EXPOSED, g$TOTAL_EXPOSED)
g$observed_uplift <- Map("-",g$e_acct_rate, g$c_acct_rate )
g$observed_uplift_sig <- Map("-",Map("/",g$e_acct_rate,g$c_acct_rate ),+1)
#mtmeans[] <- Map(`/`, mtcars, mtmeans)
#gt <- g
#g <- gt
#set limit of dataset length
L <- nrow(gtest)

rMN <- NULL
#set limit of dataset length
for (i in conf)
{
  print( c("Calculating Confidence Interval: ", i)) 
  for (n in 1:n)
  {
    xl2 <- c(gtest[n,1],gtest[n,2],gtest[n,3],gtest[n,4])
    rMN  <- rbind(rMN, subset(RRscDF(xl2, pf=F , alpha = 1-i, rnd = 2), select = c("LL", "UL")))
    
  } 
  #rMN <- NULL
  names(rMN) <- paste(names(rMN), i)
  g <- cbind(g,rMN, row.names = NULL)
  rMN <- NULL
}

ntable <- gsub("RST", "MNX", table_name)
# paste(table_name, "K", sep = "")# sep = "_") 

#dbWriteTable(conn, name, value, row.names = FALSE, overwrite = FALSE,

dbWriteTable(con, ntable, g, row.names = FALSE, overwrite = TRUE)