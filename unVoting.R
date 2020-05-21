# Importation of Dataset(United Nations Voting in General Assembly)
#Loading RDS file from website.
#First Run the file through a built in decomposser function (gzcon)
#Then load it through RBase function readRDS

unData =readRDS(gzcon(url("https://assets.datacamp.com/production/repositories/420/datasets/ddfa750d993c73026f621376f3c187f276bf0e2a/votes.rds")))

#Observing firs 5 rows of the dataset
head(unData)

#Variables names explanations
#rcid -Roll call ID- Describes one round of voting to approve UN resolution
#session - Represents the year long session when the vote was cast
#vote - Represents a country's choice. eg 1 means Yes, 9 - Country not a memeber of UN
#ccode - Country code, uniquely specifies the country
# Importing dplyr
library(dplyr)

#Filtering using pipe operator
# On vote variable we only care of 1(yes), 2(no), 3(abstain)
unData%>%

#Mutate year to since the session was after 1945
unData%>%mutate(year = session + 1945)

#The ccode represents  "Correlates of Warcodes" which are in countrycode package
library(countrycode)
#Getting the country names from the package, example
countrycode(2 , "cown", "country.name")

#Mutating country name corresponding with the ccode
unData%>%mutate(countryname = countrycode(ccode, "cown","country.name"))

#Combining the whole code assigning to unData_Processed
unData_Processsed <-unData%>%filter(vote <= 3)%>% 
mutate(countryname = countrycode(ccode, "cown","country.name"), year = session + 1945)
unData_Processsed

# Grouping and calculating mean
unData_Processsed%>%group_by(year)%>%
summarise(mean1 = mean(vote== 1),mean2 =mean(vote ==2), mean3 =mean(vote ==3))


#Sorting and Filtering processed data
by_country <- unData_Processsed %>%group_by(countryname) %>%  
summarize(total = n(),percent_yes = mean(vote == 1))
by_country%>%arrange(total)# Zanzibar had votes the least times

#Sorting and Filtering processed data
by_country <- unData_Processsed %>%group_by(countryname) %>%  
summarize(total = n(),percent_yes = mean(vote == 1))

by_country%>%arrange(total)
# Zanzibar had votes the least times


#Filtering summarized output and rremoving countries with fewer that 100 votes and rows with na's
by_country %>%arrange(percent_yes)%>%filter(total>100)%>%na.omit()

#Visualizing data with ggplot2

