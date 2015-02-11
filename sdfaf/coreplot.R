 
library(corrplot)
library(gdata)                     # documentation 
mydata = read.xls("~/DIRM20142x.xlsx")  # read from first sheet

col1 <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "white", "cyan", 
                           "#007FFF", "blue", "#00007F"))

col2 <- colorRampPalette(c("#67001F", "#B2182B", "#D6604D", "#F4A582", "#FDDBC7", 
                           "#FFFFFF", "#D1E5F0", "#92C5DE", "#4393C3", "#2166AC", "#053061"))

col3 <- colorRampPalette(c("red", "white","#F4B400", "#D84437")) 

DIRM20142 <-  read.delim("~/DIRM20142EMEA.txt", header=TRUE, dec=",",stringsAsFactors=FALSE,as.is=T, na.strings = ".")
 

#DIRM20142 <-  read.delim("~/demot.txt", header=TRUE, dec=",",stringsAsFactors=FALSE,as.is=T, na.strings = ".")

DMIR <- as.matrix(data.frame(DIRM20142[-1]))

corrplot(DMIR,is.corr = FALSE,method = "square", col = col3(100), sig.level = 0.05) 
corrplot.mixed(DMIR, is.corr = FALSE, lower = "square", upper = "circle", col = col3(100))
corrplot.mixed(DMIR, is.corr = FALSE)
corrplot(DIRM20143, is.corr = FALSE, method = "square")

as.numeric(DMIR[1,])

as.numeric(DIRM20143)
max(DMIR[,4])