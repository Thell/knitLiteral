#' @rdname block_hook
#' @export
hook_markdown_v1 <- function(before, options, envir, name="literal") {
  ##' @details markdown and rmarkdown v2 use different markdown
  ##' engines (sundown and pandoc respectively). By treating the
  ##' output differently the results can be substantially cleaner.
  if (!before || !isTRUE( knitr::opts_current$get(name)) ) return ()

  format <- "markdown"
  engine <- tolower(knitr::opts_chunk$get("engine"))
  params <- chop_params( knitr::opts_current$get("params.src"), name )
  if( grepl("literal", params, fixed = TRUE) ) {
    format <- "markdown .literal"
  }

  block.begin.prefix <- "~~~~~~ {"
  block.begin.suffix <- "}"
  block.begin <- sprintf( "%s.knitr .%s .%s %s",
                          block.begin.prefix,
                          engine,
                          format,
                          block.begin.suffix)
  block.end <- "~~~~~~"

  # Four '`'s instead of three so syntax highlight doesn't choke.
  chunk.begin.prefix <- "    ````{r"
  chunk.begin.suffix <- "}"
  chunk.begin <- sprintf( "%s %s%s",
                          chunk.begin.prefix,
                          params,
                          chunk.begin.suffix )
  chunk.end <- "    ````"

  code <- get_code(options, name)

  block <- sprintf( "%s\n%s\n%s%s\n%s\n\n",
                    block.begin,
                    chunk.begin,
                    code,
                    chunk.end,
                    block.end
  )

  return ( block )
}

#' @rdname block_hook
#' @export
hook_markdown_v2 <- function(before, options, envir, name="literal") {
  ##' @details markdown and rmarkdown v2 use different markdown
  ##' engines (sundown and pandoc respectively). By treating the
  ##' output differently the results can be substantially cleaner.
  if (!before || !isTRUE( knitr::opts_current$get(name)) ) return ()

  format <- "markdown"
  engine <- tolower(knitr::opts_chunk$get("engine"))
  params <- chop_params( knitr::opts_current$get("params.src"), name )
  if( grepl("literal", params, fixed = TRUE) ) {
    format <- "markdown .literal"
  }

  block.begin.prefix <- "`````` {"
  block.begin.suffix <- "}"
  block.begin <- sprintf( "%s.knitr .%s .%s %s %s %s",
                          block.begin.prefix,
                          engine,
                          format,
                          ifelse( isTRUE(options$number),
                                  ".number", ""),
                          ifelse( !is.null(options$startFrom),
                                  paste0( "startFrom=\"", options$startFrom, "\""),
                                  ""),
                          block.begin.suffix)
  block.end <- "``````"

  # Four '`'s instead of three so syntax highlight doesn't choke.
  chunk.begin.prefix <- "````{r"
  chunk.begin.suffix <- "}"
  chunk.begin <- sprintf( "%s %s%s",
                          chunk.begin.prefix,
                          params,
                          chunk.begin.suffix )
  chunk.end <- "````"

  code <- get_code(options, name)

  block <- sprintf( "%s\n%s\n%s%s\n%s\n\n",
                   block.begin,
                   chunk.begin,
                   code,
                   chunk.end,
                   block.end
  )

  return ( block )
}

#' @rdname block_hook
hook_markdown_latest <- hook_markdown_v2
