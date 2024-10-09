# Verificar se os pacotes estão carregados e instalados, se necessário
pacotesRequisitados <- c("tidyverse", 
                        )

for (p in pacotesRequisitados) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}



#basic programming

1/200*30

(59+73+2)/3

sin(pi/2)

x <- 3*4
#alt - <- 
x
esteÉUmNomeMuitoLongo <- 2.5

r_rocks <- 2^3
r_rocks


ggplot(data = mpg) + 
  geom_point(mapping = aes(
    x = displ, y = hwy
  ))
filter(mpg, cyl = 8)
filter(diadond, carat >3)

