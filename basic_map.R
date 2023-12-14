map_country <- function(country, x_limits = NULL, y_limits = NULL){
  ## Verifying the arguments passed to the function
  if(!is.character(country)) stop("Name of the country should be character")
  if(length(country) != 1) stop("Function supports only one country per map")
  ## Load libraries
  require(maps)
  require(ggplot2)
  if(!country %in% map_data('world')$region) stop('Country name not recognized\nTo see a list of recognized countries run <unique(maps::map_data("world")$region)>')
  ## If coords limits missing, print worldwide map with coordinates system to allow
  ## User observe coords for reference
  if(missing(x_limits) || missing(y_limits)) {
    warning("X and/or Y limits not provided.\nPrinting worldwide map.")
    map_country_theme <- theme(panel.background = element_rect(fill = '#4e91d2'))
  }
  else {
    if(length(x_limits) != 2 || length(y_limits) != 2 ||
       !all(grepl('^-?[0-9.]+$', c(x_limits, y_limits)))){
      stop("Limits for X and Y coords should be provided as vectors with two numeric values")
    }
    else {
      ## All the received inputs are correct.
      ## Let's define our custom theme for the final map 
      map_country_theme <- theme_bw() +
        theme(panel.background = element_rect(fill = '#4e91d2'),
              legend.position = 'none',
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              axis.line = element_line(colour = "black"),
              axis.title.x=element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank(),
              axis.title.y=element_blank(),
              axis.text.y=element_blank(),
              axis.ticks.y=element_blank())
    }
  }
  ## make a df with only the country to overlap
  map_data_country <- map_data('world')[map_data('world')$region == country,]
  ## The map (maps + ggplot2 )
  ggplot() +
    ## First layer: worldwide map
    geom_polygon(data = map_data("world"),
                 aes(x=long, y=lat, group = group),
                 color = '#9c9c9c', fill = '#f3f3f3') +
    ## Second layer: Country map
    geom_polygon(data = map_data_country,
                 aes(x=long, y=lat, group = group),
                 color = '#4d696e', fill = '#8caeb4') +
    coord_map() +
    coord_fixed(1.3,
                xlim = x_limits,
                ylim = y_limits) +
    ggtitle(paste0("A map of ", country)) +
    scale_x_continuous(n.breaks = 20) +
    scale_y_continuous(n.breaks = 20) +
    map_country_theme
}

## Test the function with a different country
#map_country("Brazil", c(-2, 15), c(47, 55))
