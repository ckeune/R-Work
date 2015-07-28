required_libraries <- c('ggplot2',
                        'reshape2',
                        'stringr',
                        'lubridate',
                        'dplyr',
                        'foreign',
                        'plyr',
                        'xlsx',
                        'RGoogleDocs')

#Install/load required libraries
for (lib_name in required_libraries){
  if (!require(lib_name, character.only = T)) 
    install.packages(lib_name)
  library(lib_name, character.only = T)
}

#import data - Change the directory to suit your needs. 
mydata2  <- read.spss("C:/Users/chris.keune/Documents/CreativeTest/p21103_Google Hangouts_4 ads test_V2.sav", to.data.frame=T )
getnames <- read.xlsx("C:/Users/chris.keune/Documents/CreativeTest/Google Hangouts_ReadingGuide_DataFile.xlsx", sheetName="Sheet1")

#remove any columns with no data
mydata2 <- mydata2[,(names(mydata2) %in% getnames[,1])]

#rename the columns to something that makes sense
names(mydata2) <- getnames[,2]
# table(mydata2$familiarity)
# cdata <- ddply(mydata2, c("version", "familiarity"), summarise,
#                N    = length(familiarity),
#                total = sum(weight) 
# )
#  

## write to XLSX on your computer
write.xlsx2(mydata2,"C:/Users/chris.keune/Documents/CreativeTest/p21103_Google Hangouts_4dataexport.xlsx", sheetName="Metrixlab",
            col.names=TRUE, row.names=TRUE)


##optional - Upload the file to Google Docs for Archive 


suppressMessages(library("RGoogleDocs"))

## Load password
load("gpasswd.Rdata")

## Something to write
text <- "Hello world!\n"

## Authentificate
auth <- getGoogleAuth("fellgernon@gmail.com", gpasswd)

## Connect to Google
con <- getGoogleDocsConnection(auth)

## Check the args for the uploading function
args(uploadDoc)



#write.csv(mydata2, "C:/Users/chris.keune/Documents/CreativeTest/p21103_Google Hangouts_4dataexport.csv")
