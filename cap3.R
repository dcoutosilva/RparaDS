install.packages(c("nycflights13", "tidyverse"))
library(nycflights13)
library(tidyverse)

view(flights)


filter(flights, month == 1, day == 1)

jan1 <- filter(flights, month == 1, day == 1)

dec25 <- filter(flights, month == 12, day == 25)

nov_dec <- filter(flights, month %in% c(11,12))
#voos em novembro e dezembro
#não funciona com pipe month == 11 | month == 12 

#encontrar voos que não estiveram atrasados em mais de duas horas
#ou 120 minutos (na chegada ou partida)

filter(flights, !(arr_delay > 120 | dep_delay > 120))

#ou 

filter(flights, arr_delay <= 120, dep_delay <= 120)

#exer1 - encontre todos os voos que:

#a) tiveram um atraso de duas horas ou mais na chegada

filter(flights, arr_delay >= 120, dep_delay >= 120)

#B) FORAM PARA HOUSTON IAH OU HOU
filter(flights, dest %in% c("IAH", "HOU"))

view(flights.carrier)