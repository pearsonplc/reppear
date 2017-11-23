
report_system_file <- function(file) {
  system.file("rmarkdown", paste0("skeleton/", file) , package = "ENRanalytics")
}

load_files <- function(path, subdir = "reports") {
  command <- path %>% list.files(full.names = T)
  file.copy(command, subdir)
}

report_show <- function(...) {
  file.path(...) %>% file.edit()
}

self_contained_enr_files <- function(template, ih_files = NULL, css_files = NULL) {

  base_format <- rmarkdown::html_document(
    includes = rmarkdown::includes(
      in_header = ih_files),
    css = css_files,
    md_extensions = "-autolink_bare_uris")

  template_arg <- which(base_format$pandoc$args == "--template") + 1L
  base_format$pandoc$args[template_arg] <- template

  base_format

}

add_repo_to_yaml <- function(file) {
  input_lines <- rmarkdown:::read_lines_utf8(file, getOption("encoding"))

  partitions <- rmarkdown:::partition_yaml_front_matter(input_lines)
  yaml <- partitions$front_matter

  # yaml <- yaml[1:(length(yaml) - 1)] %>% paste(collapse = "\n")
  bit_url <- extract_repo_url()

  author_line <- which(stringr::str_detect(yaml, pattern = "^author_email"))
  yaml[author_line] <- paste0(yaml[author_line], bit_url)
  yaml <- paste(yaml, collapse = "\n")

  # new_yaml <- c(yaml, bit_url)
  cat(yaml, file = file)

}

extract_repo_url <- function() {

  if (!file.exists(".git/config")) {
    warning("There is not git included in this project. URL to bitbucket repo was not included in index.html.", call. = F)
    # bit_yaml <- "\n---"
  }
  else {
    git_config <- readLines(".git/config")
    url <- stringr::str_detect(git_config, pattern = "^\turl")
    url <- git_config[url]
    url <- strsplit(url, split = "@") %>% unlist()

    bit_yaml <- paste0("\nbitbucket_url: https://", url[2])
  }
}
