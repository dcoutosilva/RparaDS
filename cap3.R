#VERIFICAR SE O PACOTE ESTÁ CARREGADO
pacotesRequisitados = c("nycflights13", "tidyverse", "httpgd")
for(p in pacotesRequisitados){
  if(!require(
    p, character.only = TRUE
  ))
    install.packages(p)
  library(p,character.only = TRUE)
}

flights


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



#adicionar novas variaveis com mutate()

flights_sml <-
  select(
    flights, year:day, ends_with("delay"), distance, air_time
  )
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
       )

#criação de novas variaveis, como gain e speed, já calculando respectivamente

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
       )

transmute(
  flights,
  gain = arr_delay - dep_delay,
  hours = air_time / 60,
  gain_per_hours = gain / hours
)#apenas manter as novas variaveis, porém não se altera na original

view(flights)


#funções de criação uteis

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
          )
#%/%  divisão inteira
#%% divisão apenas resto

#log()
#log2()
#log10()

#offsets

#lead()
#lag()

x <- 1:10
lag(x)
lead(x)
x != lag(x)
x - lag(x)
x - lead(x)

cumsum(x)#somatoria da variavel x

cummean(x) #somatória da media da variavel x

#classificação

y <-  c(1,2,2,NA,3,4)
min_rank(y)
min_rank(desc(y))
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)
ntile(y)


#exer1 pg58

#por exemplo....
#horário 15:04 (24-formats)

1504%/% 100
#15

1504%%100
#4

#converter o horário em minutos

1504%/%100 * 60 + 1504 %% 100
#904 - ou seja em minutos


flights_time <- mutate(
  flights,
  dep_time_mins = (dep_time %/%100 * 60 + dep_time %%100) %% 1440, # 1440 = 24 hours * 60 minutes
  sched_dep_time_mins = (sched_dep_time %/% 100 * 60 + sched_dep_time %% 100) %% 1440,
)
select(flights_time, dep_time, dep_time_mins, sched_dep_time, sched_dep_time_mins)

#fazendo uma função

time2mins <- function(x)
{
  (x%/%100 * 60 + x %% 100) %% 1440
}

flights_time <- mutate(
  flights,
  dep_time_mins = time2mins(dep_time),
  sched_dep_time_mins = time2mins(sched_dep_time)
)

select(flights_time, dep_time, dep_time_mins, sched_dep_time, sched_dep_time_mins)

#FAZER EXER 2 3

#EXER 4
#exemplo de ranking

rankme <- tibble(
  x = c(10,54,2,3,9,8,45,21,32,65,45,21,32)
)

rankme <- mutate(
  rankme,
  n_linha = row_number(x),
  min_rank = min_rank(x),
  ordem_rank = dense_rank(x)
)

arrange(rankme, x)

#------------------#

#começando o exercicio

flights_delayed <-
  mutate(flights,
         dep_delay_min_rank = min_rank(desc(dep_delay)),
         dep_delay_row_number = row_number(desc(dep_delay)),
         dep_delay_dense_rank = dense_rank(desc(dep_delay))
         )


flights_delayed <- filter(
  flights_delayed,
  !(dep_delay_min_rank > 10 |
    dep_delay_row_number > 10 |
    dep_delay_dense_rank > 10)
)

flights_delayed <- arrange(flights_delayed, dep_delay_min_rank)

view(select(flights_delayed, month, day, carrier, flight, dep_delay,
             dep_delay_min_rank, dep_delay_row_number, dep_delay_dense_rank ),
      n=Inf)

#ler documentação min_rank()

#exer 5

1:3 + 1:10

#adição de dois vetores.
#comprimento do objeto maior não é multiplo do comprimento do objeto menor

#seria eu estaria tentando fazer seria

c(1+1,2+2,3+3,1+4,2+5,3+6,1+7,2+8,3+9,1+10)

#resumos agrupados com summarize pg 59

summarize(
  flights,
  delay = mean(
    dep_delay, na.rm = TRUE
  )
)

#similar ao grup_by

by_day <- group_by(flights, year, month, day)
summarize(by_day,
          delay = mean(
            dep_delay, na.rm = TRUE
            )
          )

#combinações com pipe


#distância e o atraso médio para cada localização

#exemplo

by_dest <-  group_by(flights, dest)
delay <-  summarize(by_dest,
                    count = n(),
                    dist = mean(distance, na.rm = TRUE),
                    delay = mean(arr_delay, na.rm = TRUE)
                  )
                  delay <- filter(delay, count > 20, dest != "HNL")

ggplot(
  data = delay,
  mapping = aes(
    x = dist, y = delay
  )
) +
  geom_point(
    aes(
      size = count
    ), alpha = 1/8
  ) +
  geom_smooth( se = FALSE )

#3 passos
#agrupar voos por destino
#resumir para calcular a distância, o atraso médio e o número de voos
#filtar para remover os pontos ruidosos

#vamos verificar atraves do pipe %>% (crtl + shift + m)

delays <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")


#Valores faltantes

#argumento na.rm

flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay, na.rm = TRUE))

#ou tbm, adicionar a variavel para filtar

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

flight %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay, na.rm = TRUE))

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

#counts
#sempre que for contar, talvez sugira contagem n()
#ou uma contagem com os valores não faltantes sum(!is.na(x))

#vamos observar os aviões que tem os maiores atrasos médios.

delays <-  not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay)
  )
ggplot(
  data = delays,
  mapping = aes(
    x = delay
  )
) +
  geom_freqpoly(binwidth = 10)


delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(
      arr_delay, na.rm = TRUE
    ),
    n = n()
  )
ggplot(
  data = delays,
  mapping = aes(
    x = n, y = delay
  )
) +
  geom_point(alpha = 1/10)

delays %>%
  filter( n > 25 ) %>%
  ggplot(mapping = aes(
    x = n, y = delay
  )) +
  geom_point(alpha = 1/10)

#medidas de localização
#mean(x)

#median(x)

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    #media delay
    avg_delay1 = mean(arr_delay),
    #media positiva delay
    avg_delay2 = mean(arr_delay[arr_delay > 0 ])
  )

#medidas de dispersão
#sd(x) IQR(x) mad(x)

# desvio padrão sd, variação interquartil IQR, desvio absoluto mediano mad

#por ue a distância para alguns destinos é mais variavel do que outras?

not_cancelled %>%
  group_by(dest) %>%
  summarize(distance_sd = sd(distance)) %>%
  arrange(desc(distance_sd))

#medidas de classificação min(), quantile(x, 0.25), max()

#quando o primeiro e o ultimo voos partiram a cada dia?

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    first = min(dep_time),
    last = max(dep_time)
  )


#first(), nth(x,2), last()

not_cancelled %>%
  group_by(year, month, day) %>%
  mutate(r = min_rank(desc(dep_time))) %>%
  filter(r %in% range(r))

#range()A função na linguagem R é usada para obter os
#valores mínimo e máximo do vetor transmitidos a ele como argumento.

#contagens
#n(), que não recebe argumentos e retorna o tamanho do grupo atual.
#para contar o numeros de valores distintos (unicos), use n_distinct(x)

not_cancelled %>%
  group_by(dest) %>%
  summarize(carriers = n_distinct(carrier)) %>%
  arrange(desc(carriers))


not_cancelled %>%
  count(dest)

not_cancelled %>%
  count(tailnum, wt = distance)

#quantos voos partiram antes das 5h?

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(n_early = sum(dep_time < 500))

#qual proporção de voos estão atrasados em mais de uma hora?

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(hour_per = mean(arr_delay > 60))

#agrupando por multiplas variaveis
#cada resumo descola um nivel de agrupamento

daily <- group_by(flights, year, month, day)
(per_day <- summarize(daily, flights = n()))#por dia
view(per_day)

(per_month <- summarize(per_day, flights = sum(flights))) #por mes

(per_year <- summarize(per_month, flights = sum(flights))) #por ano 2013

#desagrupando


print(daily)

daily %>%
  ungroup() %>%
  summarize(flights = n())

#exercicios
#1 - faça o brainstorming de pelo menos cinco maneiras diferentes de avaliar as
#caracteristicas do atraso típico de um grupo de voos.
#um voo está 15 minutos adiantado em 50% do tempo e 15 minutos atrasado em 50% do tempo
#um voo que esta sempre atrasado em 10 minutos
#um voo está 30 minutos adiantado em 50% do tempo e 30 minutos atrasado em 50% do tempo
#em 99% do tempo um voo está no horário. em 1% do tempo, está 2 horas atrasado.

#exercicio 2
#o mesmo resultado que not_cancelled %>% count(dest ) e not_cancelled %>%
count(tailnum, wt=distance)

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(tailnum) %>%
  tally(distance)

# tally é equivalente a um contador....df %>% summarise(n = n())

#4 numeros de voos cancelados por dia

#primeiramente filtrar os voos cancelados

cancelados_por_dia <-
  flights %>%
  mutate( cancelados = (is.na(arr_delay) | is.na(dep_delay))) %>%
  group_by(year, month, day) %>%
  summarise(
    soma_cancelados = sum(cancelados),
    num_flights = n(),
  )

ggplot(cancelados_por_dia) +
  geom_point(
    aes(
      x = soma_cancelados,
      y = num_flights
    )
  )


#a proporção de voos cancelados está relacionado ao atraso medio?

cancelados_atrasados <-
  flights %>%
  mutate(cancelados = (is.na(dep_delay) | is.na(arr_delay))) %>%
  group_by(year, month, day) %>%
  summarise(
    proporcao_cancelados = mean(cancelados),
    media_dep_delay = mean(dep_delay, na.rm = TRUE),
    media_arr_delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  ungroup()

ggplot(cancelados_atrasados) +
  geom_point(aes(
    x = media_dep_delay,
    y = proporcao_cancelados
  ))

ggplot(cancelados_atrasados) +
  geom_point(aes(
    x = media_arr_delay,
    y = proporcao_cancelados
  ))


#5 qual a companhia com os piores atrasos?
#aeroportos ruins versus companhias ruins?

flights %>%
  group_by(carrier) %>%
  summarise(arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(arr_delay))

#calculei a media de atraso de cada companhia aerea.
#assim, ordenei para os mais atrasos desc.

filter(airlines, carrier == 'F9')
#frontier Airlines INC.


flights %>%
  filter(!is.na(arr_delay)) %>%
  #remove os valores ausentes
  group_by(origin, dest, carrier) %>%
  #Agrupa voos por origem, destino e transportadora.
  summarise(
    arr_delay = sum(arr_delay),
    flights = n()
  ) %>%
  # Calcula o atraso total e o número de voos para cada grupo.
  group_by(origin, dest) %>%
  #agrupa os voos em origem e destino
  mutate(
    arr_delay_total = sum(arr_delay),
    flights_total = sum(flights)
  ) %>%
  #Calcula o atraso total e o numero total de voos para cada par de origem e destino
  ungroup() %>%
  mutate(
    arr_delay_others = (arr_delay_total - arr_delay) /
      (flights_total - flights),
    #calcula o atraso medio de outras companhias para cada par de origem-destino
    arr_delay_mean = arr_delay / flights,
    #calcula o atraso medio para cada companhia de cada par origem-destino
    arr_delay_diff = arr_delay_mean - arr_delay_others
    #diferencial dos atrasos
  ) %>%

  filter(is.finite(arr_delay_diff)) %>%
  #filtra valores não finitos em arr_delay_diff
  group_by(carrier) %>%
  #agrupa os voos pela companhia
  summarise(arr_delay_diff = mean(arr_delay_diff)) %>%
  #calcula a diferença média de atraso para cada companhia em seus pares de
  #origem-destino
  arrange(desc(arr_delay_diff))
#ordena os resultados em ordem descrecente

#https://github.com/AleksandarKirilov/Homeworks

#exercicios 6

#para cada avião, conte o numero de voos antes do primeiro atraso de mais de uma hora.

#exercicio 7

#o que argumento sort para count() faz? quando você pode usá-lo?

#ordenação

flights %>%
  count(dest, sort = TRUE)


#MUDANÇAS AGRUPADAS E FILTROS

flights_sml %>%
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay))< 10)

popular_dest <- flights %>%
  group_by(dest) %>%
  filter(n() > 365)


#fazer os exercicios da pag 75




