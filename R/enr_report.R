#' Template for ENR report
#'
#' @export 
#' @param before_body html file you want to add. Specifically, the report uses information from _header.html and _tooltip_content.html.
#'

enr_report <- function(before_body) {
  
  # before body files
  # bb_files <- extract_path(paths = c('_header.html', '_tooltip_content.html'))
  
  ih_files <- report_system_file(file = c('www/tooltipster/js/tooltipster.bundle.min.js', 'www/js/bootstrap.min.js', 
                                     'www/js/scripts.js', 'www/js/comment.js', 'www/annotations/js/annotator.js',
                                     'www/annotations/js/jquery.imgareaselect.min.js', 
                                     'www/annotations/js/annotator.imgselect.js', 'www/annotations/js/bootstrap-typeahead.js', 
                                     'www/annotations/js/mention.js'))
  
  ab_files <- report_system_file(file = c('www/partials/ga_tracking_code.html', 'www/partials/comments.html', 
                                     'www/annotations/js/script_annotations.js', 'www/annotations/js/autocomplete.js'))
  
  css_files <- report_system_file(file = c('www/css/style_markdown.css', 'www/tooltipster/css/tooltipster.bundle.min.css', 
                                      'www/tooltipster/css/tooltipster-sideTip-borderless.min.css', 
                                      'www/annotations/font-awesome/css/font-awesome.min.css', 'www/annotations/css/annotator_enr.css', 
                                      'www/annotations/css/imgareaselect-default.css'))
  
  # call the base html_document function
  rmarkdown::html_document(toc = TRUE,
                           smart = FALSE,
                           toc_depth = 4,
                           toc_float = list(collapsed = FALSE),
                           includes = rmarkdown::includes(
                                               before_body = before_body,
                                               in_header = ih_files,
                                               after_body = ab_files),
                           css = css_files)
}
