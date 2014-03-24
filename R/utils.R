#' Removes all trailing chunk parameters beginning at the
#' last appearance of \code{name=} or any \code{opts.label} matching
#' \code{"name.*"}.
#' 
#' @note Be sure that the provided hook name is unique enough to not
#'   match unintentded paramters.
#' @param params.src string as returned by \code{opts_chunk$get("params.src")}.
#' @param name Name of the hook as \code{$set} in knitr.
#' 
#' @return \code{character vector} of the modified parameters.
chop_params <- function(params.src, name="literal")
{
  re <- paste0( '(?:(?![,]\\s?', name, '\\s?[=]\\s?).)*' )
  m1 <- tail( gregexpr(re, params.src, perl=TRUE)[[1]], 1 ) - 1
  
  re <- paste0( '(?:(?![,]\\s?opts[.]label\\s?[=]\\s?[\"]',
                name,
                '.*[\"]).)*' )
  m2 <- tail( gregexpr(re, params.src, perl=TRUE)[[1]], 1 ) - 1
  
  params.src <- substr( params.src, 1, max(m1,m2) )
  gsub( "([,\\s])+$", "", params.src, perl=TRUE )
}

#' Knitr expanded source code for the chunk.
#'
#' @param options Chunk paramters as provided by the knitr hook call.
#' @param name Name of the hook as \code{$set} in knitr.
#'
#' @note Honors \code{tidy} as knitr does.
#' 
#' @return \code{character vector} of the modified parameters.
get_code <- function(options, name) {

  if( !is.null(options$literal.opts) &&
        isTRUE( options$literal.opts$empty) ) {
    code <- ""
  } else {
    code <- options$code
    if (options$tidy && length(code)) {
      res <- try( silent=TRUE, expr = do.call(
        formatR::tidy.source, c(list(text = code, output = FALSE),
                       options$tidy.opts)
      ))
      if (!inherits(res, 'try-error')) {
        code <- native_encode(res$text.tidy)
      } else {
        warning('failed to tidy R code in chunk <',
                     options$label, '>\n', 'reason: ', res)
      }
    }
    code <-knitr::knit_expand( text=code )
    if( substr(code, nchar(code)-1, nchar(code)) != "\n" )
      code <- paste0( code, "\n")
  }
  return (code)
}

# Pulled in from knitr package's non-exported functions.
native_encode <- function (x, to = "") 
{
  enc = Encoding(x)
  idx = enc != "unknown"
  if (to == "") {
    x2 = x
    if (any(idx)) 
      x2[idx] = iconv(x2[idx], enc[idx][1L], to)
    if (any(is.na(x2))) {
      warning("some characters may not work under the current locale")
    }
    else x = x2
  }
  else x = iconv(x, if (any(idx)) 
    enc[idx][1L]
    else "", to)
  x
}
