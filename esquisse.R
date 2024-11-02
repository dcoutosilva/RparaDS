pacotesRequisitados <- c("esquisse"
                         , "tidyverse")


for (p in pacotesRequisitados) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

mpg

ggplot(mpg) +
  aes(x = model, y = year) +
  geom_col(fill = "#112446") +
  coord_polar(theta = "y") +
  theme_void()


esquisser(mpg)
