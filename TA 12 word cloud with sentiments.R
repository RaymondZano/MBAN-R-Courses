##########################################
#### Creating sentiment wordclouds #######
##########################################
install.packages("wordcloud")
install.packages("RColorBrewer")
library(RColorBrewer)
library(wordcloud)
data("stop_words")

original_books <- austen_books() %>%
  group_by(book) %>%
  mutate(lienumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE))))%>%
  ungroup() %>%
  unnest_tokens(word, text)%>%
  filter(book == "Emma") %>%
  anti_join(stop_words) %>%
  count(word, sort=T)

original_books %>%
  with(wordcloud(word, n, max.words = 100))

###################################################
#### Adding positive and negative sentiments ######
###################################################
install.packages("reshape2")
library(reshape2)
original_books %>%
  inner_join(get_sentiments("loughran")) %>% #adding the sentiment
  count(word, sentiment, sort=TRUE) %>%
  acast(word ~sentiment, value.var="nn", fill=0) %>%
  comparison.cloud(colors = c("grey20", "gray80"),
                   max.words=100)
