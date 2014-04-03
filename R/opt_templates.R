#' knitr option templates
#' @name opt_template
#' @rdname opt_template
#'
#' @description knitr chunk option templates to be used with
#'   the knitr \code{opts.label} parameter.
#'
#' @details Calls \code{knitr::opts_template$set()} for each
#'   builtin option template for the matching \code{out.format}.
#'
#' @param name name of the hook; used to prefix option templates.
#' @param out.format Name of out.format as given by
#'  \code{opts_knit$get("out.format")}
NULL

#' Dispatches for the option templates to be set in knitr.
#' @rdname opt_template
#'
#' @return block_hook returns the \code{hook_} function for out.format.
opt_templates <- function(out.format, name='literal')
{
  templates <- switch( out.format,
                       html = opt_templates_html(),
                       latex = opt_templates_latex(),
                       {
                         # default
                         opt_templates_markdown()
                       } )
  names(templates) <- gsub( "literal", name, names(templates) )
  templates
}

#' @rdname opt_template
#' @export
opt_templates_html <- function()
{
  #' @details Not implemented yet.
}

#' @rdname opt_template
#' @export
opt_templates_latex <- function()
{
  #' @details Not implemented yet.
}

#' @rdname opt_template
#' @export
opt_templates_markdown <- function()
{
  list(
  "literal"= list( literal=TRUE,
                   eval=FALSE,
                   echo=FALSE,
                   results="markdown"),
  "literal-eval"= list( literal=TRUE,
                        echo=FALSE,
                        results="markdown"),
  "literal-reuse"= list( literal=TRUE,
                         eval=FALSE,
                         echo=FALSE,
                         results="markdown",
                         literal.opts=list(empty=TRUE)),
  "literal-quote"= list( literal=TRUE,
                         echo=FALSE,
                         indent="> ",
                         results="markdown"),
  "literal-literal"= list( literal=TRUE,
                           eval=FALSE,
                           echo=FALSE,
                           indent="> ",
                           literal.opts=list(empty=TRUE),
                           results="markdown")
  )
}

