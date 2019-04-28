library(rvest)
library(dplyr)

baseUrl <- 'https://www.yelp.com/search'

srchwrds <- c("?find_desc=Restaurants&find_loc=New+York,+NY&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Los+Angeles,+CA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Chicago,+IL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Dallas,+TX&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Houston,+TX&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Washington,+DC&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Philadelphia,+PA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Miami,+FL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Atlanta,+GA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Boston,+MA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=San+Francisco,+CA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Phoenix,+AZ&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Riverside,+CA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Detroit,+MI&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Seattle,+WA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Minneapolis,+MN&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=San+Diego,+CA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Tampa,+FL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Denver,+CO&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=St.+Louis,+MO&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Baltimore,+MD&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Charlotte,+NC&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Orlando,+FL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=San+Antonio,+TX&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Portland,+OR&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Pittsburgh,+PA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Sacramento,+CA&cflt=restaurants",
              "?find_desc=Restaurants&find_loc=Cincinnati,+OH&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Las+Vegas,+NV&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Kansas+City,+MO&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Austin,+TX&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Cleveland,+OH&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Columbus,+OH&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Indianapolis,+IN&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=San+Jose,+CA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Nashville,+TN&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Virginia+Beach,+VA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Providence,+RI&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Milwaukee,+WI&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Jacksonville,+FL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Oklahoma+City,+OK&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Memphis,+TN&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Raleigh,+NC&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Louisville,+KY&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Richmond,+VA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=New+Orleans,+LA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Hartford+CT&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Salt+Lake+City,+UT&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Birmingham,+AL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Buffalo,+NY&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Rochester,+NY&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Rapids,+MI&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Tucson,+AZ&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Honolulu,+HI&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Tulsa,+OK&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Fresno,+CA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Bridgeport,+CT&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Worcester,+MA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Omaha,+NE&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Albuquerque,+NM&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Greenville,+SC&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Bakersfield,+CA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Albany,+NY&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Knoxville,+TN&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=New+Haven,+CT&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=McAllen,+TX&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Oxnard,+CA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=El+Paso,+TX&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Allentown,+PA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Baton+Rouge,+LA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Columbia,+SC&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Dayton,+OH&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Sarasota,+FL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Charleston,+SC&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Greensboro,+NC&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Little+Rock,+AR&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Stockton,+CA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Cape+Coral,+FL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Colorado+Springs,+CO&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Akron,+OH&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Boise+City,+ID&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Lakeland,+FL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Winston-Salem,+NC&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Syracuse,+NY&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Ogden,+UT&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Madison,+WI&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Wichita,+KS&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Daytona+Beach,+FL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Des+Moines,+IA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Springfield,+MA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Toledo,+OH&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Provo,+UT&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Augusta,+GA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Jackson,+MS&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Palm+Bay,+FL&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Harrisburg,+PA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Durham,+NC&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Spokane,+WA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Scranton,+PA&cflt=restaurants", 
              "?find_desc=Restaurants&find_loc=Chattanooga,+TN&cflt=restaurants")


result <- sapply(srchwrds, function(x) {
  paste0(baseUrl, x) %>% 
    read_html() %>% 
    html_nodes('.text-align--right__373c0__3ARv7') %>%
    html_text()
})

#Create data.frame
YelpPull <- data.frame(keyName=names(result), value=result, row.names=NULL)

#Rename columns
YelpPull <- rename(YelpPull, "RestaurantCount" = "value")
YelpPull <- rename(YelpPull, "Location" = "keyName")


#SPILT TEXT TO COLUMNS (R VERSION)
#First I need to spilt out the YelpID, this takes two steps
#Then I need to spilt out the count of restaurants 
install.packages("splitstackshape")
library(splitstackshape)
YelpFinal <- cSplit(YelpPull, "Location", "Restaurants&find_loc=")
YelpFinal <- cSplit(YelpFinal, "Location_2", "&cflt=")
YelpFinal <- cSplit(YelpFinal, "RestaurantCount", "of ")

#Remove columns I don't need 
YelpFinal <- within(YelpFinal, rm(Location_1, Location_2_2, RestaurantCount_1, RestaurantCount_2))

#Rename columns
YelpFinal <- rename(YelpFinal, "RestaurantCount" = "RestaurantCount_3")
YelpFinal <- rename(YelpFinal, "YelpLocationCode" = "Location_2_1")

