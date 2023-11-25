library(tidyverse)

mpg

#criando um ggplot

#renomear variavéis
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

#data = mpg + 
#  rename('tamanho do motor' = displ,
#         'eficiência do combustível' = hwy)

#pagina 6
#ex 1

ggplot(data=mpg) # pagina em branco sem acessos a dados.

#pag 6 
#exer 4

ggplot(data = mpg) + 
  geom_point(
    mapping = aes(
      x=hwy, y=cyl
    )
  )

#pag 8 

ggplot(data = mpg) +
  geom_point(
    mapping = aes(
      x = displ, y = hwy, color = class
    )
  )

ggplot(data=mpg) + 
  geom_point(
    mapping = aes(
      x=displ, y=hwy, size=class
    )
  )

#top
ggplot(data=mpg)+
  geom_point(
    mapping = aes(
      x=displ, y=hwy, alpha=class
    )
  )
#bottom

ggplot(data=mpg)+
  geom_point(
    mapping = aes(
      x=displ, y=hwy, shape=class #utilização de 6 classes, se houver mais categorias fica fora
    )
  )

#podemos configurar as propriedades manualmente
#deixando todos os pontos azuis por exemplo

ggplot(
  data=mpg
) + 
  geom_point(
    mapping = aes(
      x=displ, y=hwy
    ), color="blue" # a cor não transmite a informação sobre uma variável
  )

#facetas

ggplot( data = mpg ) +
  geom_point(
    mapping = aes(
      x = displ, y = hwy
    )
  ) + 
  facet_wrap(
    ~ class, nrow = 2
  )

#combinação com mais variáveis

ggplot( data = mpg ) +
  geom_point(
    mapping = aes(
      x = displ, y = hwy
    )
  ) + 
  facet_grid( drv ~ cyl)


ggplot( data = mpg ) +
  geom_point(
    mapping = aes(
      x = displ, y = hwy
    )
  ) + 
  facet_grid( . ~ cyl)

#fazer os exercicios da pag 15

#exer 2

ggplot( data = mpg ) +
  geom_point(
    mapping = aes(
      x = drv, y = cyl
    )
  ) + 
  facet_grid( drv ~ cyl) #não entendi

#exer3

ggplot( data = mpg ) +
  geom_point(
    mapping = aes(
      x = displ, y = hwy
    )
  ) + 
  facet_grid(
    drv ~ .
  )


ggplot( data = mpg ) +
  geom_point(
    mapping = aes(
      x = displ, y = hwy
    )
  ) + 
  facet_grid(
     . ~ cyl
  )

#fazendo de acordo com a varíavel.

#exer 4

ggplot(data = mpg) + 
  geom_point(
    mapping = aes(
      x = displ, y = hwy
    )
  ) + 
  facet_wrap( ~ class, ncol = 4)
#as variáveis ficam isoladas, cada gráfico para cada variável, ao inves de um grafíco
#para muitas variaveis.

#exer 5
 #nrow dividi-se em linhas
#ncol dividi-se em colunas
#facet_grid não tem variaveis nrow e ncol pois são de acordo com variaveis as quais você insere de
#acordo

#objetos geométricos pag 16

#left 
ggplot( data = mpg ) +
  geom_point(
    mapping = aes(
      x = displ, y = hwy
    )
  )
#right
ggplot( data = mpg ) +
  geom_smooth(
    mapping = aes(
      x = displ, y = hwy
    )
  )

ggplot( data = mpg ) +
  geom_smooth(
    mapping = aes(
      x = displ, y = hwy, linetype = drv
    )
  )
#4 quer dizer tração nas quatro rodas
#f tração dianteira
#r tração traseira
#pag 18




























































