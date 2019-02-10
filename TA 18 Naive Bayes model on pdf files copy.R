#install.packages("quanteda")#natural language processing package ?quanteda
#install.packages("RColorBrewer")
#install.packages("ggplot2")

library(quanteda)
library(RColorBrewer)
library(ggplot2)

#loading the pdf files:
library(pdftools) # we need this library to use pdf_text
library(tm)
setwd("~/Desktop/TA/Data/pdf")
nm <- list.files(path="~/Desktop/TA/data/pdf")

# the readPDF function doesn't actually read the PDF files, 
#the read PDF creates a function to read in all the PDF files
Rpdf <- readPDF(control = list(text = "-layout"))
opinions <- Corpus(URISource(nm), 
                   readerControl = list(reader = Rpdf))
#we need to convert the VCorpus from the previous point to
#a regular corpus using the corpus() function.
msg.dfm <- dfm(corpus(opinions), tolower = TRUE) #generating document 
msg.dfm <- dfm_trim(msg.dfm, min_count = 2, min_docfreq = 1)
msg.dfm <- dfm_weight(msg.dfm, type = "tfidf")

head(msg.dfm)
#let's split the docs into training and testing data
msg.dfm.train<-msg.dfm[1:5,]
msg.dfm.test<-msg.dfm[5:6,]

#building the Naive Bayes model:
NB_classifier <- textmodel_nb(msg.dfm.train, c(1,1,1,0,0))
NB_classifier
summary(NB_classifier)

# predicting the testing data
pred <- predict(NB_classifier, msg.dfm.test)
pred
