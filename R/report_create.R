#' Function which bulid template for ENR report
#'
#' @export
#' @param file Rmd file name which we want to create.
#' @param subdir subdirectory name where we want to store our report. Default value: 'reports'
#' @examples
#' \dontrun{
#' report_create('001_initial_report')
#'      }

report_create <- function(file, subdir = "reports"){

  file_name <- paste0(subdir, "/", file, ".Rmd")
  files_cnt <- list.dirs(subdir) %>% length()

  if (files_cnt == 1) {
    rmarkdown::draft(file_name, template = "enr_report", package = "reppear", edit = FALSE)
    load_files(path = report_system_file(''), subdir = subdir)
    report_show(subdir, file, paste0(file, '.Rmd'))
    add_repo_to_yaml(file.path(subdir, "index.Rmd"))
  }

  else if (files_cnt == 0) {
    warning(paste0("There is no subdirectory '", subdir, "' in your project. Please use correct name."), call. = FALSE)
  }

  else if (files_cnt > 1) {
    rmarkdown::draft(file_name, template = "enr_report", package = "reppear", edit = FALSE)
    report_show(subdir, file, paste0(file, '.Rmd'))
  }

}
