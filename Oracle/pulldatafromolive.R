
install.packages("RODBC") 
 

library(RODBC)
con <-odbcConnect("Olive11", uid="olive", pwd="olive_tr33s")
#sqlSave(con, test_table, "TEST_TABLE")
g <-sqlQuery(con,  "select * from DS_20141028_RST_0ZV157LCHOGDG@analyst")

liaox <-sqlQuery(con, "select * from DS_20150126_ACT_QB6DPZJO3XAZC")
#d <- sqlQuery(con, "select * from TEST_TABLE")
close(con)
