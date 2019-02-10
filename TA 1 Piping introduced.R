library(dplyr)

arrange(
  summarize(
    group_by(
      filter(mtcars, carb > 1),cyl
    ),
    Avg_mpg = mean(mpg)
  ),
  desc(Avg_mpg) 
) #nested version of lines 16-19

mtcars

#multiple objects option
a <- filter(mtcars, carb > 1)
b <- group_by(a, cyl) #
c <- summarise(b, Avg_mpg = mean(mpg)) #where aggregation happens
d <- arrange (c, desc(Avg_mpg))

#this is what piping approach does
library(magrittr)
library(dplyr)

mtcars %>%
  filter (carb >1) %>% #where
  group_by(cyl) %>% #group_by
  summarise(Avg_mpg = mean(mpg)) %>% #select
  arrange(desc(Avg_mpg)) #order by

#SQL language
SELECT * avg(mpg)
FROM mtcars
WHERE car > 1
GROUP BY cyl

