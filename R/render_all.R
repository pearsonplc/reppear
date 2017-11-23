#' Function which render all Rmd files in project
#' 
#' @export
#' @param index_file Rmd index file name which we want to render.
#' @param subdir subdirectory name where we want to store our report. Default value: 'reports'
#' @examples 
#' \dontrun{
#' render_all(index_file = "index", subdir = "reports")
#' }
#'

render_all <- function(index_file = "index", subdir = "reports") {
  
  render_index(index_file, subdir)
  
  rmd_dirs <- list.dirs(path = subdir, recursive = F)
  
  for (dir in rmd_dirs) {
    rmd_file <- list.files(dir, pattern = "[.]Rmd$", full.names = T)
    suppressWarnings(rmarkdown::render(rmd_file, quiet = TRUE))
  }
  
  message("Success! All Rmd files has been rendered.")
}
