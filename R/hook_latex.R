#' @rdname block_hook
#' @export
hook_latex <- function(before, options, envir, name="literal")
{
  format <- "latex"
  engine <- tolower(opts_chunk$get("engine"))

  if (!before || !isTRUE( knitr::opts_current$get(name)) ) return ()

  # Prepare block and chunk parameters.
  params <- chop_params( knitr::opts_current$get("params.src"), name)
  params <- paste( paste0( "list(", params, ")" ), collapse=",")
  params <- highr::hi_latex(params)
  params <- gsub( "^\\\\hlkwd\\{list\\}\\\\hlstd\\{\\(\\}", "", params)
  params <- gsub( "\\\\\\hlstd\\{\\)\\}$", "", params)

#   code <- options$code
  code <- get_code(options, name)
  if ( nzchar(code) ) {
    code <- highr::hi_latex(code)
    code <- paste(code, collapse="\n")
  }
  if ( !isTRUE( options$literal.opts$empty) ) {
    code <- paste0( code, "\n")
  }

  pat <- block_patterns[["latex"]]

  block <- with( pat, knitr::knit_expand(text=pat$expansion) )

  return ( block )

}
