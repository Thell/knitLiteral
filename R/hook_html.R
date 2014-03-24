#' @rdname block_hook
#' @export
hook_html <- function(before, options, envir, name="literal")
{
  format <- "html"
  engine <- tolower(opts_chunk$get("engine"))
}