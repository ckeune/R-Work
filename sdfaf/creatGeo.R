Geo=gvisGeoChart(Exports, locationvar="Country", 
                 colorvar="Profit",
                 options=list(projection="kavrayskiy-vii"))
plot(Geo)



countryFreqs <- read.delim("~/DIRCountryFreqs.txt")
Geo=gvisGeoChart(countryFreqs, locationvar="country", 
                 colorvar="avgimps",
                 options=list(projection="kavrayskiy-vii"))
plot(Geo)
