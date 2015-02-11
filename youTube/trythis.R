
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
                        'shinyGoogleCharts',
                        'rga',
                        'dplyr',
                        'plyr')
)

#Install/load required libraries
for (lib_name in required_libraries){
  if (!require(lib_name, character.only = T)) 
    install.packages(lib_name)
  library(lib_name, character.only = T)
}



# 1. Find OAuth settings for google:
  google <- oauth_endpoint(NULL, "auth", "token", base_url = "https://accounts.google.com/o/oauth2")

# 2. Register an application at https://code.google.com/apis/console#access
myapp <- oauth_app("google", "{my app id}.apps.googleusercontent.com", secret = "{my secret}")

# 3. Get OAuth credentials
cred <- oauth2.0_token(google, myapp, scope = "https://www.googleapis.com/auth/yt-analytics.readonly")