

##### fuzzy join
fuzzy_join_1 = readxl::read_xlsx("Desktop/fuzzy_join.xlsx")
fuzzy_join_2 = readxl::read_xlsx("Desktop/fuzzy_join.xlsx", sheet = 2)

library(fuzzyjoin)
library(stringr)
library(tidyverse)

stringdist_left_join(fuzzy_join_1, fuzzy_join_2, by = 'name',method = 'jaccard', max_dist = 0.7)

stringdist_left_join(fuzzy_join_1, fuzzy_join_2, by = 'name',method = 'jw', max_dist = 0.4)

stringdist_left_join(fuzzy_join_1, fuzzy_join_2, by = 'name',method = 'soundex', max_dist = 0.7)


