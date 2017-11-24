#' Function that calculates readability index given link to the markdown file
#' Calculate the average of the 5 readability scores:
#' Flesch Kincaid, Gunning Fog Index, Coleman Liau, SMOG, Automated Readability Index
#' 
#' @export
#' @param link a link of Rmd document
#' 

mean_readability <- function(link) {
  
  # Extract text from markdown file
  scan(link, 'character', quiet = T) %>% paste(collapse = " ") %>% 
    
    # remove all line breaks, http://stackoverflow.com/a/21781150/1036500
    gsub("[\r\n]", " ", .) %>% 
    
    # don't include front yaml
    gsub("---.*--- ", "", .) %>% 
    
    # don't include text in code chunks: https://regex101.com/#python
    gsub("```\\{.+?\\}.+?```", "", .) %>% 
    
    # don't include text in in-line R code
    gsub("`r.+?`", "", .) %>% 
    
    # don't include HTML comments
    gsub("<!--.+?-->", "", .) %>% 
    
    # don't include inline markdown URLs
    gsub("\\(http.+?\\)", "", .) %>% 
    
    # don't include images with captions
    gsub("!\\[.+?\\)", "", .) %>% 
    
    # don't include # for headings
    gsub("#*", "", .) %>% 
    
    # don't include html tags
    gsub("<.+?>|</.+?>", "", .) %>% 
    
    # don't include boldings
    gsub("__", "", .) %>% 
    
    # don't include bulleting
    gsub("*", "", ., fixed = T) %>% 
    
    # don't go back button
    gsub("← Go back to index page", "", ., fixed = T) %>% 
    
    # don't include section id's
    gsub("\\{.+?\\}", "", .) %>% 
    
    # Replace multiple spaces by one
    gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", ., perl = TRUE) %>% 
    
    # Calculate readability
    readability::readability(NULL) %>% 
    
    # Extract the average
    .$Average_Grade_Level %>% 
    
    # Round
    round(1)
}