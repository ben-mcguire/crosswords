# Crossword Theme Construction in R

If you do crosswords a lot, you can start to get a feel for how themes are constructed and puzzles are designed, and you might get the itch to try one yourself. Usually, you can figure out a whole theme just with some creative thinking and time - you'll think of a pun, add another few examples, and be able to dive right into construction in an app. But other times, you might not be able to find enough examples, or just have the bones of a concept but not enough fill to get going. In these cases, some simple R code can help you drive toward a stable of theme answers fast, and the code in this repo is designed as a starter kit to do just that.

### Sources and Tools
- I use the free [Crosserville](https://www.crosserville.com/) but there are tons of good free (and/or pretty cheap) options
- For a word list, [Peter Broda's free version](https://peterbroda.me/crosswords/wordlist/) is pretty big (500K usable words) is a good starter
- I use [One Look](onelook.com) very frequently to think about how to incorporate clues and concepts, even when I've decided on a theme - really fast way to vet common words and phrases that might fit into your concept
- R and R Studio are free to download and use, and the only real limitation here will be your local storage and processing power

## Code in this Repo

### Find Inner Substring in A String
One of the simplest themes that might benefit from some coding scale is finding a word or phrase hidden inside another word or phrase. The best versions of these are usually the unexpected ones - when the end of one word plus the start of the next word in a phrase creates an unexpected and unrelated word. 

As a silly example, a puzzle themed on REVERSE MOTION might benefit from finding the word JOG spelled backwards in MANGO JUICE - but finding those can be a slow process. This is a very simple R script that finds all of the internal matches fast and returns a list you can scan to find the gems. 

### Adding / Subtracting a Substring in A String
A widely-used theme family is taking a substring and adding it to or subtracting it from a larger string. There are a few varieties - for example, there might be a word that has been added to a string to create a new, unrelated word. As a simple example, if you add an 'inner ear' (i.e., the substring EAR) to the word FIRM, you can create FIREARM, and if you add a 'spare part' (i.e., PART) to the word WARY, you can create WARPARTY. 

Sometimes you'll notice these coincidences in the wild and can just collect them, but doing it that way (or searching through entries in an online dictionary like [OneLook](onelook.com) can take a while. 

The code here uses a quick substitution script to grab your chosen substring and check for valid combinations, then spits out a clean file that lets you quickly comb through and pick your favorites. In case your theme has particular parameters like 'starting' or 'finishing' or 'middle', the code also lets you pass in a stipulation about where the substring should be located.

### The Caesar Cipher
A [Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher) is an old device that (aprocryphally, iirc) is attributed to Julius Caesar for encrypting and sending messages during wartime. The concept is very simple - a message is 'ciphered' by just rolling forward each letter through the alphabet so that it is indistinguishable as the original message without that number to roll it back. 

This is a bit niche to try to pull off in a crossword but I think it's a fun example of what you can do with some quick and dirty R code and a somehwat complex theme. As an example, ROBYN and HEROD are both Caesar Ciphers of EBOLA (+3 and +13, respectively) - and using this code surfaces those as options for your 'message' encryption. It runs a bit slow locally so I added a progress bar.
