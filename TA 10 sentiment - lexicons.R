# Sentiment in tidytext()
library(tidytext)
print(sentiments)

unique(sentiments$sentiment) #this is the qualitative
unique(sentiments$lexicon)#this is the lexicon source
summary(sentiments$score) # this is 3rd score that we can use / quantitative

#########################################################
##### Lets take a look at the lexicons one by one #######
#########################################################
#how can we subset the data to get distinct lexicons?
nrc_data <- subset(sentiments, lexicon == "nrc")
unique(nrc_data$sentiment) # these are the nrc options of sentiment labels

bing_data <- subset(sentiments, lexicon == "bing")
unique(bing_data$sentiment)

afinn_data <- subset(sentiments, lexicon == "AFINN")
unique(afinn_data$sentiment)

loughran_data <- subset(sentiments, lexicon == "loughran")
unique(loughran_data$sentiment)

get_sentiments("afinn")
get_sentiments("nrc")
get_sentiments("bing")
get_sentiments("loughran")

