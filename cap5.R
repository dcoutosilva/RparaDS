#Verifica Pacotes
pack = c("tidyverse")
for(p in pack){
  if(!require(
    p, character.only = TRUE
  ))
    install.packages(p)
  library(p,character.only = TRUE)
}