# Processes the TV and Radio Data from Corporation of Public Broadcasting Station finder
# https://www.cpb.org/cpb-station-finder/


library(rvest)
library(purrr)
library(dplyr)


# Creates a vector of characters for # of pages

radio_numbers <-as.character(c(0:23))
tv_numbers <-as.character(c(0:7))


# Creates the URls where the data is to be pulled from
# by joining the generic URLs with the page numbers

for(i in radio_numbers)
{
  radio_urls <- paste("https://www.cpb.org/cpb-station-finder/None/Radio?page=",
                radio_numbers,
                sep="")
}
for(i in tv_numbers)
{
  tv_urls <- paste("https://www.cpb.org/cpb-station-finder/None/TV?page=",
                   tv_numbers,
                   sep="")
}


# Using map function on the list of urls, reading as an html, parsing it as table
# and converting it into a tibble dataframe

radio_table <- map(urls,
                   ~{read_html(.x) %>% 
                       html_node("table") %>% 
                       html_table() %>% 
                       tbl_df() 
                       Sys.sleep(5)})

tv_table <- map(urls,
                ~{read_html(.x) %>%
                    html_node("table") %>%
                    html_table() %>%
                    tbl_df()
                    Sys.sleep(5)})



# Dropping Link table as it is NA

new_radio_table <- map(radio_table,~{.x %>% select(-Link)})
new_tv_table <- map(tv_table,~{.x %>% select(-Link)})


# Binding the list of dataframes into one 

final_radio_data <- bind_rows(new_table)
final_tv_data <- bind_rows(new_table)
