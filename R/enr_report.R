#' Template for ENR report
#'
#' @export
#' @param before_body html file you want to add. Specifically, the report uses information from _header.html and _tooltip_content.html.
#'

enr_report <- function(before_body) {

  # before body files
  # bb_files <- extract_path(paths = c('_header.html', '_tooltip_content.html'))

  ih_files <- report_system_file(file = c('tooltipster/js/tooltipster.bundle.min.js', 'js/bootstrap.min.js',
                                          'js/scripts.js', 'js/comment.js', 'annotations/js/annotator.js',
                                          'annotations/js/jquery.imgareaselect.min.js',
                                          'annotations/js/annotator.imgselect.js', 'annotations/js/bootstrap-typeahead.js',
                                          'annotations/js/mention.js'),
                                 root = "skeleton/www")

  ab_files <- report_system_file(file = c('partials/ga_tracking_code.html', 'partials/comments.html',
                                          'annotations/js/script_annotations.js', 'annotations/js/autocomplete.js'),
                                 root = "skeleton/www")

  css_files <- report_system_file(file = c('css/style_markdown.css', 'tooltipster/css/tooltipster.bundle.min.css',
                                           'tooltipster/css/tooltipster-sideTip-borderless.min.css',
                                           'annotations/font-awesome/css/font-awesome.min.css', 'annotations/css/annotator_enr.css',
                                           'annotations/css/imgareaselect-default.css'),
                                  root = "skeleton/www")

  # call the base html_document function
  base_format <- rmarkdown::html_document(
    toc = TRUE,
    smart = FALSE,
    toc_depth = 4,
    toc_float = list(collapsed = FALSE),
    includes = rmarkdown::includes(
      before_body = before_body,
      in_header = ih_files,
      after_body = ab_files),
    css = css_files)

  pre_processor <- function(metadata,
                            input_file,
                            runtime,
                            knit_meta,
                            files_dir,
                            output_dir) {

    custom_files <- list(ih_files, ab_files, css_files)
    custom_names <- list("header", "after_body", "css") %>% paste0("deps/", .)
    purrr::walk2(custom_files, custom_names, ~file.copy(.x, .y))

    invisible(NULL)
  }

  rmarkdown::output_format(
    knitr = NULL,
    pandoc = NULL,
    pre_processor = pre_processor,
    base_format = base_format
  )

}
