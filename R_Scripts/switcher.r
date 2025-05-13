library(readr)
library(dplyr)
library(stringr)
library(progress)

words_df <- read_csv("~/Desktop/xwordlist.csv", col_types = cols(word = col_character()))
word_list <- as.character(words_df$word)
word_list <- word_list[!is.na(word_list)]

switcher <- function(substring_pairs, word_list) {
  total_checks <- length(word_list) * nrow(substring_pairs)
  
  pb <- progress_bar$new(
    format = "Processing [:bar] :percent ETA: :eta",
    total = total_checks, clear = FALSE, width = 60
  )
  
  results <- list()
  
  for (i in seq_len(nrow(substring_pairs))) {
    substr1 <- substring_pairs$substring1[i]
    substr2 <- substring_pairs$substring2[i]
    
    pair_results <- lapply(word_list, function(word) {
      pb$tick()
      if (!is.na(word) && str_detect(word, fixed(substr1))) {
        new_word <- str_replace(word, fixed(substr1), substr2)
        if (!is.na(new_word) && new_word %in% word_list) {
          return(data.frame(
            substring1 = substr1,
            substring2 = substr2,
            original_word = word,
            new_word = new_word,
            original_length = nchar(word),
            new_length = nchar(new_word),
            stringsAsFactors = FALSE
          ))
        }
      }
      return(NULL)
    })
    
    results[[i]] <- bind_rows(pair_results)
  }
  
  bind_rows(results)
}

substring_pairs <- data.frame(
  substring1 = c("DEM","DEM","REP","DEM","REP","IND"),
  substring2 = c("REP","IND","IND","LIB","LIB","LIB"),
  stringsAsFactors = FALSE
)

switcher_results <- switcher(substring_pairs, word_list)
View(switcher_results)
