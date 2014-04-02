knitLiteral
===========

[![Build Status](https://travis-ci.org/Thell/knitLiteral.svg?branch=master)](https://travis-ci.org/Thell/knitLiteral)

A knitr hook to output chunks as you _intend_ them to be displayed
for examples and tutorials.

Motivation
----------
When writing documents _about_ [knitr] usage I wanted to be able to
output a full chunk as it _would_ be written and it seems I'm not
the only one.

Currently [knitr-examples][] [$062$][knitr-examples-062] and
[$065$][knitr-examples-065] give methods of accomplishing a wrap
of the _current_ option labels and the code. Another common option
is wrapping html tags around chunks ([authoring rcodechunks]).
Thankfully some nice results can be obtained using the hooking
mechanisms provided by Yihui in knitr ([example 1] and [example 2]).

In the end something is needed that will

*  Be in line with the spirit of the knitr front end.  
   ( Easy to use and explain. )
*  Follow the DRY/SPOT principle.
*  Enhance reproducability.  
   ( Literally cut and paste into new source documents. )
*  Be accessible for styling and scripting in the final output.
*  Be compatible with multiple knitr input/output combinations.

and most of all...

*  **Follow the [original philosophy] of markdown.**

    >  ...
    >  A Markdown-formatted document should be publishable as-is,
    >  as plain text, without looking like it’s been marked up
    >  with tags or formatting instructions.
    >  ...

Also see the [upcoming version](rmarkdown.rstudio.com) of [r markdown][markdown].

Installing
----------

Install from source using devtools:
```
install_github("thell/knitLiteral")
```


Usage
-----------

**Basic**

Create your source document as normal. In your setup chunk include

```
knitLiteral::kast_on()
```

At the end of your chunk parameters include `literal=TRUE`, then knit.


**Advanced**

Naming: 

A "name" argument may be provided to `kast_on`. When a name is
provided the parameter name, option template names and the
associated .opts parameter will use it.

Chunk Parameters:

Knitr processes chunk parameters in the order they appear in the
chunk header so any chunk options following the `literal=TRUE` will
be active _but will not appear in the output_ giving you the ability
to create chunks that literally display what you want.

Option Templates:

Some option templates have been provided and can be enabled in the
setup chunk with the `templates` flag of the `kast_on` function.
Any `opts.label` template beginning with the kast hook's name are
treated the same as `literal=TRUE` for output.

literal.opts:

    `empty=TRUE` - omit chunk contents from output.

At this time only a single option is available.

Styling:

Each literal chunk is giving a unique id with classes assigned
to assist in styling.

-----

<!--- References --->

  [original philosophy]: http://daringfireball.net/projects/markdown/syntax#philosophy "Daring Fireball"
   [knitr]: <URL:http://yihui.name/knitr/>
     "Xie Y (2013). _knitr: A general-purpose package for dynamic report generation in R_. R package version 1.5.22."  
   [markdown]: <http://CRAN.R-project.org/package=markdown>
     "Allaire J, Horner J, Marti V and Porte N (2014). _markdown: Markdown rendering for R_. R package version 0.6.4."  
   [authoring rcodechunks]: https://raw.githubusercontent.com/rstudio/rmarkdown/gh-pages/authoring_rcodechunks.md "rmarkdown v2 help page source"
   [example 1]: http://rpubs.com/Thell/literalize
   [example 2]: http://ramnathv.github.io/posts/verbatim-chunks-knitr/index.html
   [knitr-examples]: https://github.com/yihui/knitr-examples "github: knitr-examples"
   [knitr-examples-062]: https://github.com/yihui/knitr-examples/blob/master/062-chunk-wrapper.Rmd "github: knitr-examples 062"
   [knitr-examples-065]: https://github.com/yihui/knitr-examples/blob/master/065-rmd-chunk.Rmd "github: knitr-examples 065"
