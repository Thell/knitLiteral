#' Chunk Block building hooks.
#' @name block_hook
#' @rdname block_hook
#'
#' @description Block building knitr hooks.
#'
#' @param before If \code{TRUE} chunk code has not been executed.
#' @param options Current knitr chunk options.
#' @param envir Environment in which code chunk is evaluated.
#' @param name Name of the hook as \code{$set} in knitr.
#' @return \code{character vector} of built block if \code{before}
#' is \code{TRUE}.
NULL

#' Dispatches the block building hook to be set in knitr.
#'
#' @param out.format Name of out.format as given by
#'  \code{opts_knit$get("out.format")}
#'
#' @return block_hook returns the \code{hook_} function for out.format.
block_hook <- function( out.format="markdown" )
{
  switch( out.format,
          html = hook_html,
          latex = hook_latex,
          {
            rmd.version <- knitr::opts_knit$get("rmarkdown.version")
            if( is.null(rmd.version) ) {
              hook_markdown_v1
            } else {
              hook_markdown_latest
            }
          }
  )
}
