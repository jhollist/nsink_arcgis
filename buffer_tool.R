#' Example R-ArcGIS Bridge tool
#' 
#' Takes input data from ArcGIS, regresses y on x and adds predicted values back 
#' to the feature class
#' @examples 
#' in_params <- list()
#' in_params$x <- 1948121
#' in_params$y <- 2295822
#' tool_exec(in_params)
tool_exec <- function(in_params, out_params = NULL){
  aea<- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
  loc <- c(in_params$x, in_params$y)
  out_fc <- out_params$output_data
  loc_sf <- sf::st_sf(sf::st_sfc(sf::st_point(loc), crs = aea))
  loc_buff <- sf::st_buffer(loc_sf, 1000)
  arcgisbinding::arc.write(out_params$output_data, loc_buff, overwrite = TRUE)
  
  return(out_params)
}