install.packages('tidyverse')
library(tidyverse)

mpg #carregamento de dados

#criando um ggplot

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

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(
      x = displ, y = hwy
    )
  )
ggplot( data = mpg ) +
  geom_smooth(
    mapping = aes(
      x = displ, y = hwy, group = drv
    )
  )
ggplot( data = mpg) +
  geom_smooth(
    mapping = aes(
      x = displ, y = hwy, color = drv
    ),
    show.legend = FALSE
  )

#Para exibir vários geoms no mesmo gráfico 

ggplot(data = mpg) + 
  geom_point(
    mapping = aes(
      x = displ, y = hwy
    )
  ) +
  geom_smooth(
    mapping = aes(
      x = displ, y = hwy
    )
  )
#duplicação de código, pois estou plotando os mesmo dados em dois tipos de gráficos diferentes
#péssimo para manutenção do código.. o mais correto seria.

ggplot(
  data = mpg, mapping = aes(
    x = displ, y = hwy
  )
)+
  geom_point() +
  geom_smooth()

#para limpeza do código, é o mais correto..
#podemos modificar umas das propriedades

ggplot(
  data = mpg, mapping = aes(
    x = displ, y = hwy
  )
) + 
  geom_point(
    mapping = aes(
      color = class
    )
  ) + 
  geom_smooth()

#pag 20 usando filter

ggplot(
  data = mpg, mapping = aes(
    x = displ, y = hwy
  )
) + 
  geom_point(
    mapping = aes(
      color = class
    )
  ) + 
  geom_smooth(
    data = filter(
      mpg, class == "compact"
    ), se = TRUE
  )

#exer 2

ggplot(
  data =  mpg,
  mapping = aes(
    x = displ, y = hwy, color = drv
  )) +
    geom_point() +
    geom_smooth( 
      se = TRUE
      )

#exer 5 

ggplot(
  data = mpg, mapping = aes(
    x = displ, y = hwy
  )) +
  geom_point() +
  geom_smooth()
#--------------------------------------------
ggplot() +
  geom_point(
    data = mpg, mapping = aes(
      x = displ, y = hwy
    )) +
  geom_smooth(
    data = mpg,
    mapping = aes(
      x = displ, y = hwy
    )
  )
#não existe diferença nos dois gráficos.

#transformações estatísticas
#pag 22

# --------------------------------------------------------------------------------------------#

diamonds

ggplot(data = diamonds) +
  geom_bar(mapping = aes(
    x = cut
  ))

ggplot(
  data = diamonds
) +
  stat_count(mapping = aes(
    x = cut
  ))

demo <- tribble(
  ~a, ~b,
  "bar1", 20,
  "bar2", 30,
  "bar3", 40
)
ggplot(data = demo) +
  geom_bar(
    mapping = aes(
      x = a, y = b
    ), stat = "identity"
  )


ggplot(
  data  = diamonds
) +
  geom_bar(
    mapping = aes(
      x = cut, y = ..prop.., group = 1
    )
  )

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(
      x = cut, y = depth
    ), 
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
#ajustes de posição
#pg 27
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(
      x = cut, color = cut
    )
  )
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(
      x = cut, fill = cut
    )
  )

#não consigo exibir os dois graficos ao mesmo tempo

ggplot( data = diamonds ) +
  geom_bar(
    mapping = aes(
      x = cut, fill = clarity
    )
  )

















































