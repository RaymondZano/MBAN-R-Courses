library(textreadr)
MBA <- read_document(file="~/Desktop/TA/Day 2/MBA.txt")
MIB <- read_document(file="~/Desktop/TA/Day 2/MIB.txt")
class_combo <- c(MBA, MIB)

a <- 60 #how many observations to you have
b <- 9 #how many variables do you have
my_df <- as.data.frame(matrix(nrow=a, ncol=b))

for(z in 1:b){
  for(i in 1:a){
    my_df[i,z]<- class_combo[i*b+z-b]
  }#closing z loop
}#closing i loop

my_txt <- my_df$V6
my_txt <- substr(my_txt, start=11 , stop = 10000)#removing the You said part in python app

library(dplyr)
mydf <- data_frame(line=1:a, text=my_txt)
print(mydf)


library(dplyr)
library(stringr)
library(tidytext)

data(stop_words)
frequencies_tokens_nostop <- mydf %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>% #here's where we remove tokens
  count(word, sort=TRUE)


print(frequencies_tokens_nostop)
