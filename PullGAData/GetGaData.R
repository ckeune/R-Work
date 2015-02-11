
install.packages("RGoogleAnalytics")

devtools::install_github("Tatvic/RGoogleAnalytics")

required_libraries <- c('ggplot2',
                        'reshape2',
                        'stringr',
                        'lubridate',
                        'dplyr',
                        'scales',
                        'googleVis',
                        'shiny',
                        'magrittr', 
                        'lattice',
                        #'shinyGoogleCharts',
                        #'rga',
                        'dplyr',
                        'plyr',
                        'httr',
                        'lubridate')
  
#Install/load required libraries
for (lib_name in required_libraries){
  if (!require(lib_name, character.only = T)) 
    install.packages(lib_name)
  library(lib_name, character.only = T)
}

#ga <- GoogleAnalyticsAPI()


token <- Auth( "1050576292712-g93goifrbdk4irjhijlutcov7motb5ht.apps.googleusercontent.com", "26fH1NtY5mJLfgqcekXQ5z_z")


# Save the token object for future sessions
save(token,file="./token_file")


ValidateToken(token)

#get the ga profiles
profilelist <- GetProfiles(token)


# Build a list of all the Query Parameters
query.list <- Init(start.date = "2014-1-01",
                   end.date = "2014-08-31",
                   dimensions = "ga:yearMonth ,ga:medium",
                   metrics = "ga:sessions,ga:pageviews",
                   max.results = 10000,
                   sort = "-ga:yearMonth",
                   table.id = "ga:63294194")
# Create the Query Builder object so that the query parameters are validated
ga.query <- QueryBuilder(query.list)
# Extract the data and store it in a data-frame
ga.data <- GetReportData(ga.query, token, split_daywise = f)




