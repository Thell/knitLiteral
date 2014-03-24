#' Set the knitr hook.
#'
#' @param name Name string to use for chunk option, option template
#'   and .opt prefixes.
#' @param templates If \code{TRUE} option templates will be enabled.
#' @param include_styles include supported styling files after body.
#'
#' @return invisible \code{TRUE} on success.
#'
#' @note templates provided include: \cr
#' "name" eval=FALSE, echo=FALSE \cr
#' "name-eval" echo=FALSE \cr
#' "name-reuse" eval=FALSE, echo=FALSE, literal.opts=list(empty=TRUE) \cr
#' "name-quote" echo=FALSE, results="asis", indent="> "
#'
#' @export
kast_on <- function( name = "literal",
                     templates = TRUE,
                     include_styles = TRUE )
{
  res <- try( stopifnot( length(name) == 1,
                         identical( make.names(name), name ),
                         length(templates) == 1,
                         is.logical(templates) )
  )
  if( inherits(res, "try-error") ) {
    warning(res)
    return ( invisible(FALSE) )
  }

  format <- knitr::opts_knit$get("out.format")

  hook <- list( block_hook(format) )
  names(hook) <- name
  knitr::knit_hooks$set( hook )

  if( isTRUE(templates) ) {
    knitr::opts_template$set( opt_templates(format, name) )
  }

  if( isTRUE(include_styles) ) {
    # Something to auto-include the supporting files instead
    # of requiring 'asis' chunks at the end of the document.
  }

  invisible( TRUE )
}
