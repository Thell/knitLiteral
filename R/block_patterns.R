#' All built-in patterns
#'
#' This object is a named list of built-in block level pattern texts.
#' @export
block_patterns = list(
  `rnw` = list(
    block.begin.prefix = '',
    block.begin.suffix = '',
    block.end = '',
    chunk.begin.prefix = '<<',
    chunk.begin.suffix = '>>=',
    chunk.end = '@'
  ),

  `brew` = list(''),

  `tex` = list(
    block.begin.prefix = '',
    block.begin.suffix = '',
    block.end = '',
    chunk.begin.prefix = '%% begin.rcode',
    chunk.begin.suffix = '',
    chunk.end = '%% End.rcode'
  ),

  `html` = list(
    block.begin.prefix = '',
    block.begin.suffix = '',
    block.end = '',
    chunk.begin.prefix = '<!--begin.rcode',
    chunk.begin.suffix = '',
    chunk.end = 'end.rcode-->'
  ),

  `markdown_v1` = list(
    block.begin.prefix = '`````` {',
    block.begin.suffix = '}',
    block.end = '``````',
    chunk.begin.prefix = '    ````{r',
    chunk.begin.suffix = '}',
    chunk.end = '    ````',
    indent.code = TRUE,
    code.leader = '    ',
    expansion = paste( "{{block.begin.prefix}}",
                       ".knitr .{{engine}} .{{format}}",
                       "{{block.begin.suffix}}\n",
                       "{{chunk.begin.prefix}}",
                       "{{params}}",
                       "{{chunk.begin.suffix}}\n",
                       "{{code}}",
                       "{{chunk.end}}\n",
                       "{{block.end}}",
                       collpase='', sep='')
  ),

  `markdown_v2` = list(
    block.begin.prefix = '`````` {',
    block.begin.suffix = '}',
    block.end = '``````',
    chunk.begin.prefix = '````{r',
    chunk.begin.suffix = '}',
    chunk.end = '````',
    indent.code = FALSE,
    code.leader = '',
    expansion = paste( "{{block.begin.prefix}}",
                       ".knitr .{{engine}} .{{format}}",
                       "{{block.begin.suffix}}\n",
                       "{{chunk.begin.prefix}}",
                       "{{params}}",
                       "{{chunk.begin.suffix}}\n",
                       "{{code}}",
                       "{{chunk.end}}\n",
                       "{{block.end}}",
                       collpase='', sep='')
  ),

  `rst` = list(
    block.begin.prefix = '',
    block.begin.suffix = '',
    block.end = '',
    chunk.begin.prefix = '.. {',
    chunk.begin.suffix = '}',
    chunk.end = '.. ..'
  ),

  `asciidoc` = list(
    block.begin.prefix = '',
    block.begin.suffix = '',
    block.end = '',
    chunk.begin.prefix = '// begin.rcode ',
    chunk.begin.suffix = '',
    chunk.end = '// end.rcode'
  ),

  `textile` = list(
    block.begin.prefix = '',
    block.begin.suffix = '',
    block.end = '',
    chunk.begin.prefix = '### begin.rcode',
    chunk.begin.suffix = '',
    chunk.end = '### end.rcode'
  )
)
