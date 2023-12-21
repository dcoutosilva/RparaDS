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

#c) operados pela United, American ou Delta
# Contando o número de voos por companhia aérea
contagem_por_companhia <- table(flights$carrier)

# Imprimindo a contagem
print(contagem_por_companhia)

#assumindo que, United seja UA... American seja AA e Delta seja DL
#Logo.

UA_AA_DL <- filter(flights, carrier %in% c("UA", "AA", "DL"))
view(UA_AA_DL)

#D) Partiram em julho, agosto e setembro

jul_ago_set <- filter(flights, month %in% c(07,08,09))
view(jul_ago_set)

#E) chegaram com mais de duas horas de atraso, mas não saíram atrasados

filter(flights, arr_delay > 120, dep_delay <= 0)

#F) atrasaram pelo menos uma hora, porém compensaram mais de 30 minutos durante o trajeto

filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)

#G) saíram entre meia-noite e as 6 da manhã

filter(flights, dep_time <= 600 | dep_time == 2400) #a unidade de medida da variavel
#dep_time

#exer2

#refazendo os exercicios anteriores com between

#d
filter(flights, between(month, 7, 9))

#3
filter(flights, is.na(
  dep_time
))
#fazer uma somatória
sum(is.na(flights$dep_time))

#verificando em outras variaveis

colSums(is.na(flights))










