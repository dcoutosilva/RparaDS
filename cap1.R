install.packages('tidyverse')
library(tidyverse)

mpg #carregamento de dados
view(mpg)

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

ggplot(
  data = diamonds,
  mapping = aes(
    x = cut, fill = clarity
  )
) + 
  geom_bar(
    alpha = 1/5, position = "identity" #inutil para grafico de barras, pois sobrepõe
  )
ggplot(
  data = diamonds,
  mapping = aes(
    x = cut, color = clarity
  )
) + 
  geom_bar(
    fill = NA, position = "identity" #fill = NA, torna-o completamente transparente
  )


ggplot(
  data = diamonds
) + 
  geom_bar(
    mapping = aes(
      x = cut, fill = clarity
    ), position = "fill" # position fill fica todo preenchido
    #fill funciona como empilhamento da mesma altura, facilita comparar proporções
  )

ggplot(
  data = diamonds
) + 
  geom_bar(
    mapping = aes(
      x = cut, fill = clarity
    ), position = "dodge"
  )
#dodge coloca objetos sobrepostos diretamente um ao lado do outro, facilita 
# a comparação de valores individuais

ggplot(
  data = mpg
) +
  geom_point(
    mapping = aes(
      x = displ, y = hwy
    ),
    position = "jitter"
  )
  
#para evitar sobreposição de pontos no gráficos, podemos utilizar o position = jitter
#pois ele adiciona uma pequena quantidade de ruídos aleatórios a cada ponto, isso 
#espalha os pontos, porque não é provável que dois pontos quaisquer receba
#a mesma quantidade de ruídos aleatório,

ggplot(
  data = mpg
) + geom_point(
  mapping = aes(
    x = displ, y = hwy
  ), 
  position = "stack"
)

#exer 1 pg 31
#descreve a sobreposição dos dados, é necessário adicionar o position jitter

ggplot(
  data = mpg, mapping = aes(
    x = cty, y = hwy)) +
  geom_point(
    position = "jitter")


#exer 2
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter(height = 0, width = 0)

#exer 3 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count(position = "jitter")

#exer 4
ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot(position = "identity")


#sistemas de coordenadas

#coord_flip() troca os eixos x e y, é bom para rótulos longos

ggplot(
  data = mpg, mapping = aes(
    x = class, y = hwy
  )
) + 
  geom_boxplot()
ggplot(
  data = mpg, mapping = aes(
    x = class, y = hwy
  )
) + 
  geom_boxplot() +
  coord_flip()

nz <- map_data("nz")
nz
ggplot(nz, aes(
  long, lat, group = group
)) + 
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()
#coord_quickmap configura a proporção de tela corretamente

world <- map_data("world")
ggplot(world, aes(
  long, lat, group = group
)) +
  geom_polygon(fill = "black", color = "white") +
  coord_quickmap() + theme_bw()

bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(
      x = cut, fill = cut
    ), show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()
#coord_polar usa coordenadas polares, que revelam uma conexão interessante 
#entre um gráfico de barras e gráfico de setores.
bar
#exer 1 #pg 33
ggplot(
  mpg, aes(
    x = factor(1), fill = drv
  )
) +
  geom_bar()

ggplot(
  mpg, aes(
    x = factor(1), fill = drv
  )
) +
  geom_bar(width = 1) + 
  coord_polar(theta = "y")
#o argumento theta=y é o angulo de inicio da secção

#sedeixar em branco


ggplot(
  mpg, aes(
    x = factor(1), fill = drv
  )
) +
  geom_bar(width = 1) + 
  coord_polar()

#exer2
#labs adicionda titulos, titulos plots, capitulos

ggplot(
  data = mpg, 
  mapping = aes(
    x = class, y = hwy
  )
) + 
  geom_boxplot() +
  coord_flip() +
  labs(y = "Highway MPG",
       x = "Class",
       title = "Higway MPG by car class",
       subtitle = "1999-2008",
       caption = "Source: http://fueleconomy.gov")

#exer 3 
#coord_quickmap X coord_map
#se pegarmos o mapa da NZ.
nz <- map_data("nz")
nz
ggplot(nz, aes(
  long, lat, group = group
)) + 
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()
#quickmap mantém a porporção correta dos mapas.

ggplot(nz, aes(
  long, lat, group = group
)) + 
  geom_polygon(fill = "white", color = "black") +
  coord_map()

#coord_map utiliza-se mapas de projeção de 3
#dimensões.. projeção de mercator

#coord_quickmap é a plotagem mais rapida,
#porem ela ignora a curvatura da terra
#e ajusta o mapa para lat/long ratio

#exer 4 
p<- ggplot(
  data = mpg, mapping = aes(
    x = cty, y = hwy
  )
) + geom_point() + 
  geom_abline()

p + coord_fixed()

p
  


















