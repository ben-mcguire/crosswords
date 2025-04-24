library(dplyr)
library(readr)
library(stringr)
library(purrr)
library(combinat)
library(progress)

anagrammer <- function(file_path, target_string, position = "anywhere") {
  words_df <- read_csv(file_path, show_col_types = FALSE) %>%
    filter(!is.na(word)) %>%
    mutate(word = toupper(word))
  
  word_set <- words_df$word
  
  # anagrammer
  target_string <- toupper(target_string)
  target_anagrams <- unique(permn(strsplit(target_string, "")[[1]]) %>%
                              sapply(paste0, collapse = ""))
  
  # progress bar
  pb <- progress_bar$new(
    format = "Processing [:bar] :percent ETA: :eta",
    total = length(word_set), clear = FALSE, width = 60
  )
  
  # loop
  results <- purrr::map_dfr(word_set, function(w) {
    pb$tick()
    
    matches <- switch(position,
                      start = target_anagrams[str_starts(w, target_anagrams)],
                      end = target_anagrams[str_ends(w, target_anagrams)],
                      middle = target_anagrams[purrr::map_lgl(target_anagrams, ~str_detect(w, paste0("(?<=.)", .x, "(?=.)")))],
                      anywhere = target_anagrams[str_detect(w, fixed(target_anagrams))],
                      stop("Invalid position: choose from 'start', 'middle', 'end', 'anywhere'")
    )
    
    if (length(matches) > 0) {
      tibble(word = w, anagram = matches, string_length = nchar(w))
    } else {
      NULL
    }
  })
  
  return(results)
}

results <- anagrammer("your_path.csv", "MEDIA", position = "middle")
View(results)
