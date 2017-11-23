#' Function which render index.Rmd-related files in project
#'
#' @export
#' @param index_file Rmd index file name which we want to render.
#' @param subdir subdirectory name where we want to store our report. Default value: 'reports'
#' @examples
#' \dontrun{
#' render_all(index_file = "index", subdir = "reports")
#' }
#'

render_index <- function(index_file = "index", subdir = "reports"){

  index_path <- file.path(subdir, paste0(index_file, ".Rmd"))

  rmarkdown::render(index_path, output_format = "reppear::enr_index", output_file = "index.html", quiet = T)
  rmarkdown::render(index_path, output_format = "reppear::enr_tooltip", output_file = "_tooltip_content.html", quiet = T)
  rmarkdown::render(index_path, output_format = "reppear::enr_header", output_file = "_header.html", quiet = T)

  paste0("Success! ", index_path, " has been rendered.") %>% message()
}

