#' Template for ENR index
#' @export

enr_index <- function() {

  template <- system.file("rmarkdown/templates/index/skeleton/enr_index.html", package = "ENRanalytics")
  ih_files <- report_system_file(file = c('www/js/scripts_index.js', 'www/js/jquery.min.js'))
  css_files <- report_system_file(file = c('www/css/style_index.css'))

  # execute enr_file self-contained builder
  self_contained_enr_files(template, ih_files, css_files)

}

#' @export
enr_header <- function() {

  template = system.file("rmarkdown/templates/header/skeleton/header.html" , package = "ENRanalytics")

  # execute enr_file self-contained builder
  self_contained_enr_files(template)
}

#' @export
enr_tooltip <- function() {

  template = system.file("rmarkdown/templates/tooltip/skeleton/tooltip_content.html" , package = "ENRanalytics")

  # execute enr_file self-contained builder
  self_contained_enr_files(template)
}
