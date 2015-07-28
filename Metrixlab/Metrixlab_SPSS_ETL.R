required_libraries <- c('ggplot2',
                        'reshape2',
                        'stringr',
                        'lubridate',
                        'dplyr',
                        'foreign',
                        'plyr',
                        'xlsx'
                        )

#Install/load required libraries
for (lib_name in required_libraries){
  if (!require(lib_name, character.only = T)) 
    install.packages(lib_name)
  library(lib_name, character.only = T)
}

#############################################################
#import data - Change the directory to point to your files   
spss_file <- "N:/Essence/Research/Measurement Vendors/MetrixLab/Creative Testing Materials/test/hangouts/p21103_Google Hangouts_4 ads test.sav"
reading_guide <- "N:/Essence/Research/Measurement Vendors/MetrixLab/Creative Testing Materials/test/hangouts/Google Hangouts_ReadingGuide_DataFile.xlsx"
output_file_name <- "N:/Essence/Research/Measurement Vendors/MetrixLab/Creative Testing Materials/test/hangouts/p21103_Google Hangouts_4dataexport.xlsx"

###########################################################
mydata2  <- read.spss(spss_file, to.data.frame=T )

getnames <- read.xlsx(reading_guide, sheetName="Sheet1")

#remove any columns that does not match the naming file
mydata2 <- mydata2[,(names(mydata2) %in% getnames[,1])]

#rename the columns to something that makes sense
names(mydata2) <- getnames[,2] 

#export to excel file (change directory below)
write.xlsx2(mydata2,output_file_name
            ,
            sheetName="Metrixlab",
            col.names=TRUE, row.names=F)



#write.csv(mydata2, "C:/Users/chris.keune/Documents/CreativeTest/p21103_Google Hangouts_4dataexport.csv")
