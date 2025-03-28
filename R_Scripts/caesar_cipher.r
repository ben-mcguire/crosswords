# Load the readxl package
library(readxl)
library(tidyverse)
library(dplyr)
library(progress)

# Data import
words <- read.csv("~/Desktop/xwordlist.csv", sep="")
words$word <- tolower(trimws(words$word))
words <- unique(words$word)

# Caesar cipher
caesar_cipher <- function(word, shift) {
  letters_only <- letters
  chars <- strsplit(word, "")[[1]]
  shifted <- sapply(chars, function(c) {
    if (c %in% letters_only) {
      idx <- match(c, letters_only)
      letters_only[((idx - 1 + shift) %% 26) + 1]
    } else {
      c
    }
  })
  paste0(shifted, collapse = "")
}

# Setup
word_set <- unique(words)
word_set <- word_set[nchar(word_set) >= 5 & nchar(word_set) <= 10]
word_set <- word_set[grepl("^[A-Za-z]+$", word_set)]
results <- data.frame(old_word = character(),
                      rotation = integer(),
                      new_word = character(),
                      stringsAsFactors = FALSE)
seen <- new.env(hash = TRUE)

# Progress bar
pb <- progress_bar$new(
  format = "Processing [:bar] :percent ETA: :eta",
  total = length(word_set), clear = FALSE, width = 60
)

# Main loop
for (word in word_set) {
  pb$tick()
  
  for (shift in 1:25) {
    ciphered <- caesar_cipher(word, shift)
    
    if (!is.na(ciphered) &&
        ciphered != word &&
        ciphered %in% word_set) {
      
      key <- paste(sort(c(word, ciphered)), collapse = "_")
      
      if (!exists(key, envir = seen)) {
        seen[[key]] <- TRUE
        results <- rbind(results, data.frame(
          old_word = word,
          rotation = shift,
          new_word = ciphered,
          stringsAsFactors = FALSE
        ))
      }
    }
  }
}

View(results)
