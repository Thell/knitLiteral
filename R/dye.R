#' Include supporting files for styling.
#'
#' @param out.format Name of out.format as given by
#'  \code{opts_knit$get("out.format")}
#'
#' @return character vector to include \code{asis} in te document.
#'
#' @export
dye <- function( out.format="markdown" )
{
  switch( out.format,
          html = {
            # Not implemented yet.
          },
          latex = {
            # Not implemented yet.
          },
          {
            css <- system.file("css/literalize.css", package = "knitLiteral")
            cat( readLines(css), sep="\n" )

            rmd.version <- knitr::opts_knit$get("rmarkdown.version")
            if( is.null(rmd.version) ) {
              # Javascript is used to left-align indented block using
              # 'jquery-replacetext'
              js <- system.file("js/literalize.js", package = "knitLiteral")
              cat( readLines(js), sep="\n" )
            }
          }
  )
}
