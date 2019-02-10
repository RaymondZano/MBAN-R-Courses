library("twitteR")
library("tm")

#necessary file for Windows
setwd("xxxxxxxx")
#download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

#to get your consumerKey and consumerSecret see the twitteR documentation for instructions
consumer_key <- 'xxxxxxxx' #put in your own key
consumer_secret <- 'xxxxxxxxx' #put in your own key
access_token <- 'xxxxxxxxxx' #put in your own key
access_secret <- 'xxxxxxxxxxx' #put in your own key

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
USA <- twitteR::searchTwitter('xxxxxxxxx', n = 1000, since = '2015-06-01', retryOnRateLimit = 1e3)
d = twitteR::twListToDF(USA)

EU <- twitteR::searchTwitter('xxxxxxxxxx', n = 1000, since = '2015-06-01', retryOnRateLimit = 1e3)
e = twitteR::twListToDF(EU)

##############################################
### Sentiment wordclounds for USA ############
##############################################

tidy_usa <- d %>%
  unnest_tokens(word, text) %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort=T) %>%
  ungroup()

tidy_usa #look at trump - he is positive!!! :)

tidy_usa %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word=reorder(word, n)) %>%
  ggplot(aes(word, n, fill=sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y")+
  labs(y="Contribution to sentiment", x=NULL)+
  coord_flip()

library(reshape2)
#we need to use the NRC sentiments
tidy_usa %>%
  inner_join(get_sentiments("nrc")) %>%
  count(word, sentiment, sort=TRUE) %>%
  acast(word ~sentiment, value.var="nn", fill=0) %>%
  comparison.cloud(colors = c("grey20", "gray80"),
                   max.words=100)

##############################################
### Sentiment wordclounds for EU ############
##############################################

tidy_eu <- e %>%
  unnest_tokens(word, text) %>%
  inner_join(get_sentiments("bing"))
#you must complete this yourself
