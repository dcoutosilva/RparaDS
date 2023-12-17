install.packages(c("nycflights13", "tidyverse"))
library(nycflights13)
library(tidyverse)

flights

filter(flights, month == 1, day == 1)

jan1 <- filter(flights, month == 1, day == 1)

dec25 <- filter(flights, month == 12, day == 25)

nov_dec <- filter(flights, month %in% c(11,12))
