#' @rdname block_hook
#' @export
hook_latex <- function(before, options, envir, name="literal")
{
  format <- "latex"
  engine <- tolower(opts_chunk$get("engine"))
}