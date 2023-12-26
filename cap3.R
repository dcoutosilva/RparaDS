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

#5 - teório

NA ^ 0
#1 - NA admitisse como true

NA | TRUE

FALSE & NA

NA * 0


########################################################

#arrange()
#pag 50

arrange(flights, year, month, day)

arrange(flights, desc(arr_delay))

#valores faltantes serão sempre para os últimos

df <-  tibble(x = c(5,2,NA))
arrange(df, x)
arrange(df, desc(x))

#1 pag 51

#utiliza o arrange para classificar todos os valores flatantes no começo?

arrange(flights, dep_time) %>% tail()
#função tail retorna as ultimas linhas de um data frame

#2
#os voos mais atrasados

arrange(flights, desc(dep_delay))

#os voos que sairam mais cedos, mais adiantados no seus horários.
arrange(flights, dep_delay)

#ao contrário da função tail, temos a head
#encontras os voos mais rapidos
view(head(arrange(flights, air_time)))
#acima são tbm os voos mais curtos...

#porem os mis rapidos

view(head(arrange(flights, desc(distance / air_time))))
#4
#quais voos viajam por mais tempo

arrange(flights, desc(air_time))
#viajaram por menos tempo
arrange(flights, air_time)

select(flights, year, month, day)

select(flights, year:day)

select(flights, - (year:day))

flights %>% select(starts_with("dep")) #deve iniciar com a dataframe 

flights %>% select(ends_with(c("delay", "time"))) 

flights %>%
  select(
    contains(c(
      "dep", "time"  
    ))
  )
#os que contém as expressões dep e time

flights %>%
  select(
    matches(
      "(.)\\1" #REGEX, um caracterer que seja repetido
    )
  )

#num_range ("x", 1:3 ) associa a variavel com os numeros. x1, x2, x3

rename(flights, tail_num = tailnum) #rename variável

view(flights)

select(flights, time_hour, air_time, everything())#ordens das tabelas dentro do select

select(flights, 1, 2, 3, 8, 5) #o mesmo funcionamento que o SQL

#exercicio 1 - pg 54
#faça um brainstorm de maior quantidade possível de maneiras de selecionar 
#dep_time, dep_delay, arr_time, arr_delay de flights

select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, "dep_time", "dep_delay", "arr_time", "arr_delay")

ex1pg54 <- c ("dep_time", "dep_delay", "arr_time", "arr_delay")

flights %>% select(ex1pg54)

select(flights, all_of(ex1pg54))

select(flights, 4, 6, 7, 9)

select(flights, any_of(ex1pg54))

select(
  flights, starts_with(
    c(
      "dep", "arr"
    )
  )
)

select(
  flights, ends_with(
    c(
      "time", "delay"
    )
  )
)#ERRADO ESSE EXEMPLO POIS SELECIONA MAIS VARIÁVEIS

#EXER2 

select(flights, 1, 1) #ele não repete a coluna selecionada

#exer3

vars <- c("year", "month", "day", "dep_delay", "arr_delay")

select(flights, one_of(vars))
#quase mesma função de all_of e only_of

#exer 4

select(flights, contains("TIME"))


