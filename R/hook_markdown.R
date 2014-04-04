#' @rdname block_hook
#' @export
hook_markdown_v1 <- function(before, options, envir, name="literal") {
  ##' @details markdown and rmarkdown v2 use different markdown
  ##' engines (sundown and pandoc respectively). By treating the
  ##' output differently the results can be substantially cleaner.
  if (!before || !isTRUE( knitr::opts_current$get(name)) ) return ()

  # Prepare block and chunk parameters.
  format <- "markdown"
  engine <- tolower(knitr::opts_chunk$get("engine"))
  params <- chop_params( knitr::opts_current$get("params.src"), name )

  # Unamed chunks with default params don't need a space.
  if( nzchar(params) ) {
    params <- paste0( " ", params)
  }

  # "literal-literal" chunks.
  if( grepl("literal", params, fixed = TRUE) ) {
    format <- "markdown .literal"
  }


  pat <- block_patterns[["markdown_v1"]]

  code <- get_code(options, name)
  if( isTRUE( pat$indent.code) && nzchar(code) ) {
    code <- knitr:::indent_block( code, pat$code.leader )
  }

  block <- with( pat, knitr::knit_expand(text=pat$expansion) )

  return ( block )
}

#' @rdname block_hook
#' @export
hook_markdown_v2 <- function(before, options, envir, name="literal") {
  ##' @details markdown and rmarkdown v2 use different markdown
  ##' engines (sundown and pandoc respectively). By treating the
  ##' output differently the results can be substantially cleaner.
  if (!before || !isTRUE( knitr::opts_current$get(name)) ) return ()

  # Prepare block and chunk parameters.
  format <- "markdown"
  engine <- tolower(knitr::opts_chunk$get("engine"))
  params <- chop_params( knitr::opts_current$get("params.src"), name )

  # Unamed chunks with default params don't need a space.
  if( nzchar(params) ) {
    params <- paste0( " ", params)
  }

  # "literal-literal" chunks.
  if( grepl("literal", params, fixed = TRUE) ) {
    format <- "markdown .literal"
  }

  # "Pandoc numbered literal chunks.
  if( isTRUE(options$number) ) {
    format <- paste0( format, " .number")
    if( !is.null(options$startFrom) ) {
      format <- paste0( format, " startFrom=\"", options$startFrom, "\"")
    }
  }

  pat <- block_patterns[["markdown_v2"]]
  code <- get_code(options, name)
  if( isTRUE( pat$indent.code) && nzchar(code) ) {
    code <- knitr:::indent_block( code, pat$code.leader )
  }

  block <- with( pat, knitr::knit_expand(text=pat$expansion) )

  return ( block )
}

#' @rdname block_hook
hook_markdown_latest <- hook_markdown_v2
