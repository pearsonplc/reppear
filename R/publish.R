#' Publish file or folder on kvm1 server
#' 
#' Save a file or a folder on the kvm1 server.
#' 
#' @export
#' @param file name of a file in report folder that you want to send to server. Default value: '', then whole 'report' folder will be published.
#' @param dest_folder name of the folder in which files ought be saved. Default value: '', then name of folder where the project is located will be used.
#' @examples 
#' \dontrun{
#' # save the whole 'report' catalogue on the server
#' upload_to_server() 
#' 
#' # save 'slide_deck.html' file located in 'report/slide_deck_template' folder to folder with a same name as project            
#' upload_to_server('slide_deck_template/slide_deck.html') 
#'
#' # save 'slide_deck.html' located in 'report/slide_deck_template' to folder 'why_r'
#' upload_to_server(file = 'slide_deck_template/slide_deck.html', dest_folder = 'why_r')     
#'      }

# function that upload data to the server location
publish <- function(file = '', dest_folder = ''){
  
  # gets the directory name
  if (dest_folder == ''){
    dest_folder <- system2('basename', '"$PWD"', stdout = T)    
  }
  
  # checks if directory for upload exists
  step1 <- tryCatch(system2('ssh', paste0("-t ", Sys.getenv("server_login"), "@kvm1-e01.ioki.pl 'cd ", Sys.getenv("server_folder"),  dest_folder, "'"), stdout = T, stderr = T), warning = function(c) c)
  
  if (is(step1, 'warning')) {
    message('The folder does not exists in destination directory. Creating the folder.')
    system2('ssh', paste0("-t ", Sys.getenv("server_login"), "@kvm1-e01.ioki.pl 'mkdir ", Sys.getenv("server_folder"), dest_folder, "'"), stdout = F, stderr = F)
  }
  
  # code below handles uploading folders
  if (file == ''){
    step2 <- tryCatch(upload_folder(dest_folder), warning = function(c) 'warning')
    
    # code below handles uploading files    
  } else {
    step2 <- upload_file(file, dest_folder)
    
  }
}

upload_file <- function(file = '', dest_folder = ''){
  system2('scp',
          paste0('-r ./', file, ' ', Sys.getenv("server_login"), '@kvm1-e01.ioki.pl:', Sys.getenv("server_folder"), dest_folder),
          stdout = T,
          stderr = T)
}

upload_folder <- function(dest_folder = ''){ 
  system2('scp',
          paste0('-r ./reports/*', ' ', Sys.getenv("server_login"), '@kvm1-e01.ioki.pl:', Sys.getenv("server_folder"), dest_folder),
          stdout = T,
          stderr = T)
}

