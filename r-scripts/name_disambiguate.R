name_lookup <- readr::read_csv(here::here("r-scripts/name_lookup.csv"),show_col_types = FALSE)

disambiguate <- function(input, lookup = name_lookup, d = ";"){
  # d may be , sometimes
  # input should be a name, or vector of names
  # lookup should be df as above
  pacman::p_load(magrittr,dplyr,stringr)
  #lookup <- name_lookup
  
  # First just get the basic list, in both orders.
  member_basics <- members %>%
    transmute(MemberName = toupper(paste0(LastName,", ", FirstName)),
              LookupName = paste0(LastName, " ", FirstName)
    ) %>%
    rows_append(.,
                members %>% transmute(
                  MemberName = toupper(paste0(LastName,", ", FirstName)),
                  LookupName = paste0(LastName, ", ", FirstName)
                )) %>%
    rows_append(.,
                members %>% transmute(
                  MemberName = toupper(paste0(LastName,", ", FirstName)),
                  LookupName = paste0(FirstName, ", ", LastName)
                )) %>%
    rows_append(.,
                members %>% transmute(
                  MemberName = toupper(paste0(LastName,", ", FirstName)),
                  LookupName = paste0(FirstName, " ", LastName)
                ))
  
  #then get the matching rules from the spreadsheet and also switch 
  lookup_switch <- lookup %>%
    dplyr::mutate(
      MemberName = toupper(MemberName),
      LookupName = stringr::str_trim(paste0(stringr::str_remove(LookupName,".*,"),", ",stringr::str_remove(LookupName,",.*")), "both")
    )
  
  #and append those
  lookup <- dplyr::rows_append(lookup,lookup_switch) %>%
    mutate(MemberName = toupper(MemberName))
  
  #remove redundancy (just in case) and add the basic to the lookup
  lookup <- unique(dplyr::rows_append(lookup, member_basics))
  
  #create a version replacing commas and . with '', and - with space.
  lookup_noc <- lookup %>%
    mutate(LookupName = str_replace_all(LookupName, '\\.|,', '')) %>%
    mutate(LookupName = str_replace_all(LookupName, '-', ' '))
  
  lookup <- lookup %>% dplyr::rows_append(lookup_noc) %>% unique()
  
  #add the regex so we're looking for the start and ends with our names, which allows for more flexibility
  lookup <- lookup %>% 
    dplyr::mutate(
      MemberName = toupper(MemberName),
      LookupName = paste0("(",d,"|^)", toupper(LookupName), "(",d,"|$)"))
  
  #make sure the columns are in the correct order for deframe, which takes first column as name
  lookup <- lookup %>% select(LookupName, MemberName)  
  
  #get a list of names used, this can be used later (without disambiguation) if necessary
  nms <- c(unique(lookup$MemberName),unique(lookup$LookupName))
  nms <- c(nms, stringr::str_trim(paste0(stringr::str_remove(lookup$MemberName,".*,")," ",stringr::str_remove(lookup$MemberName,",.*")), "both"))
  # lookup_switch <- lookup %>% 
  #   dplyr::mutate(
  #     MemberName = stringr::str_trim(paste0(stringr::str_remove(MemberName,".*,")," ",stringr::str_remove(MemberName,",.*")), "both")
  #   )
  #in that list also create a version without punctuation (or the regex)
  nms <- c(nms, gsub('[[:punct:] ]+',' ',nms)) %>% 
    stringr::str_trim(.) %>% unique()
  
  #deframe the lookup, this makes it a named list
  lookup <- tibble::deframe(lookup)
  
  rm(lookup_switch,member_basics)
  #input <- M$AF
  
  input <- sapply(input, function(x){
    #x <- "Bob, fil;HUNTER, JANE LOUISE; SHUM, SIMON;Bob, filSHUM, SIMON;Buckingham Shum, S.;SHUM, SIMON J. BUCKINGHAM"
    x <- strsplit(x, d) %>% unlist() %>% str_trim()
    #x <- gsub('[[:punct:] ]+',' ',x)
    x <- stringr::str_replace_all(string=stringr::str_trim(toupper(x)), pattern=lookup)
    #dimensions doesn't paste a ; for all AF (a bug I assume). 
    #cnt <- length(x)
    paste(x, collapse = d)
  }
  )
  
  unname(input)
}

#I know right
disambiguiate <- disambiguate

# strsplit_keep <- function(x,
#                           split,
#                           type = "remove",
#                           perl = FALSE,
#                           ...) {
#   if (type == "remove") {
#     # use base::strsplit
#     out <- base::strsplit(x = x, split = split, perl = perl, ...)
#   } else if (type == "before") {
#     # split before the delimiter and keep it
#     out <- base::strsplit(x = x,
#                           split = paste0("(?<=.)(?=", split, ")"),
#                           perl = TRUE,
#                           ...)
#   } else if (type == "after") {
#     # split after the delimiter and keep it
#     out <- base::strsplit(x = x,
#                           split = paste0("(?<=", split, ")"),
#                           perl = TRUE,
#                           ...)
#   } else {
#     # wrong type input
#     stop("type must be remove, after or before!")
#   }
#   return(out)
# }

#this will look for strict names, and if they blend into other text, insert a delimiter
add_delims <- function(input, lookup = name_lookup, d= ";"){
  pacman::p_load(magrittr,dplyr,stringr)
  #lookup <- name_lookup
  
  lookup <- lookup %>% 
    dplyr::mutate(MemberName = toupper(MemberName)) 
  # %>% 
  #   dplyr::mutate(
  #     #MemberName_check = paste0("(\\w)",MemberName,"(\\w)","|","(\\w)",MemberName,"|",MemberName,"(\\w)")
  #     MemberName_check_after = paste0("(\\w)",MemberName),
  #     MemberName_check_before = paste0(MemberName,"(\\w)")
  #   )
  # 
  # lookup_before <- lookup %>% select(MemberName_check_before, MemberName) %>% unique() %>% tibble::deframe()
  # lookup_after <- lookup %>% select(MemberName_check_after, MemberName) %>% unique() %>% tibble::deframe()
  # 
  # lookup <- select(MemberName_check, MemberName) %>% tibble::deframe()
  # 
  
  input <- sapply(input, function(x){
    #x <- "anothertokeep;LAUBUSSON, PETER; hELLO LAUBUSSON, PETERL;Name, Wewanttokeep;HUNTER, JANE"
    # a <- strsplit_keep(x, split = names(lookup_before), perl = T, type = "before") %>% unlist()
    # b <- strsplit_keep(a, split = names(lookup_after), perl = T, type = "after") %>% unlist()
    # x <- stringr::str_replace_all(x, lookup)
    #dimensions doesn't paste a ; for all AF (a bug I assume). 
    #cnt <- length(x)
    x <- stringr::str_split(x, ";") %>% unlist() #split the names up
    y <- stringr::str_match(x, paste(unique(lookup$MemberName), collapse="|"))
    nah_index <- c(which(is.na(y))) #get ones that didn't match
    reintegrate <- if(length(nah_index)>0) { y[c(nah_index)] <- x[c(nah_index)] }
    #y <- str_extract_all(x, lookup$MemberName, simplify=T) 
    
    paste(y, collapse = ";")
  }
  )
  input
}
