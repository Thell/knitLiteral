context("Hook naming")

test_that( "Default naming works.", {

test_text <- '
```{r hook, echo=FALSE, cache=FALSE}
(knitLiteral::kast_on())
```
'
knit_out <- knitr::knit(text=test_text, quiet=TRUE)

  expect_that( knit_out,
               prints_text("TRUE") )

test_text <- '
```{r hook_name, echo=FALSE, cache=FALSE}
knitLiteral::kast_on()
"literal" %in% names(knitr::knit_hooks$get())
```
'
knit_out <- knitr::knit(text=test_text, quiet=TRUE)

  expect_that( knit_out,
               prints_text("TRUE") )

test_text <- '
```{r templates, echo=FALSE, cache=FALSE}
knitLiteral::kast_on()
knitr::opts_template$get()
```
'
knit_out <- knitr::knit(text=test_text, quiet=TRUE)

  expect_that( knit_out,
               prints_text("literal") )
})


test_that( "Assigned naming works.", {

test_text <- '
```{r hook, echo=FALSE, cache=FALSE}
(knitLiteral::kast_on("foo"))
```
'
knit_out <- knitr::knit(text=test_text, quiet=TRUE)

  expect_that( knit_out,
               prints_text("TRUE") )

test_text <- '
```{r hook_name, echo=FALSE, cache=FALSE}
knitLiteral::kast_on("foo")
"foo" %in% names(knitr::knit_hooks$get())
```
'
  knit_out <- knitr::knit(text=test_text, quiet=TRUE)

  expect_that( knit_out,
               prints_text("TRUE") )

  test_text <- '
```{r templates, echo=FALSE, cache=FALSE}
knitLiteral::kast_on("foo")
knitr::opts_template$get()
```
'
knit_out <- knitr::knit(text=test_text, quiet=TRUE)

  expect_that( knit_out,
               prints_text("foo") )
})

test_that( "Bad name fails.", {
  expect_false( kast_on(c("foo","foo2")) )
  expect_warning( kast_on(c("foo","foo2")) )
})
