context("Param chopping")

test_that( "Lone literal is chopped.", {
  expect_that( chop_params('literal=TRUE'),
               equals('') )
  expect_that( chop_params('literal =TRUE'),
               equals('') )
  expect_that( chop_params('literal= TRUE'),
               equals('') )
  expect_that( chop_params('literal = TRUE'),
               equals('') )
  expect_that( chop_params('literal = TRUE '),
               equals('') )
})

test_that( "Lone opts.label 'literal[-._]' is chopped.", {
  expect_that( chop_params('opts.label=\"literal\"'),
               equals('') )
  expect_that( chop_params('opts.label =\"literal-testing\"'),
               equals('') )
  expect_that( chop_params('opts.label= \"literal.test-ed\"'),
               equals('') )
  expect_that( chop_params('opts.label = \"literal.test1\"'),
               equals('') )
  expect_that( chop_params('opts.label = \"literal_test-1\ "'),
               equals('') )
})

test_that( "Label remains after literal chop.", {
  expect_that( chop_params('literal,literal=TRUE'),
               equals('literal') )
  expect_that( chop_params('literal ,literal=TRUE'),
               equals('literal') )
  expect_that( chop_params('literal1, literal =TRUE'),
               equals('literal1') )
  expect_that( chop_params('literal-1 , literal= TRUE'),
               equals('literal-1') )
  expect_that( chop_params('literal.1 , literal = TRUE '),
               equals('literal.1') )
  expect_that( chop_params('literal_1 , literal = TRUE '),
               equals('literal_1') )
})

test_that( "Label remains after opts.label chop.", {
  expect_that( chop_params('label,opts.label=\"literal\"'),
               equals('label') )
  expect_that( chop_params('label ,opts.label =\"literal-testing\"'),
               equals('label') )
  expect_that( chop_params('label-1 , opts.label = \"literal-test1\"'),
               equals('label-1') )
  expect_that( chop_params('label_1, opts.label= \"literal-test-ed\"'),
               equals('label_1') )
  expect_that( chop_params('label.1 , opts.label = \"literal-test-1\ "'),
               equals('label.1') )
})

test_that( "Leading bare argument remains after literal chop.", {
  expect_that( chop_params('bare=TRUE,literal=TRUE'),
               equals('bare=TRUE') )
  expect_that( chop_params('bare=FALSE ,literal=TRUE'),
               equals('bare=FALSE') )
  expect_that( chop_params('bare, literal =TRUE'),
               equals('bare') )
  expect_that( chop_params('bare.1 , literal= TRUE'),
               equals('bare.1') )
  expect_that( chop_params('bare_1 , literal = TRUE '),
               equals('bare_1') )
})

test_that( "Leading bare argument remains after opts.label chop.", {
  expect_that( chop_params('bare=TRUE,opts.label=\"literal\"'),
               equals('bare=TRUE') )
  expect_that( chop_params('bare=FALSE ,opts.label =\"literal-testing\"'),
               equals('bare=FALSE') )
  expect_that( chop_params('bare, opts.label= \"literal-test-ed\"'),
               equals('bare') )
  expect_that( chop_params('bare.1 , opts.label = \"literal-test1\"'),
               equals('bare.1') )
  expect_that( chop_params('bare_1 , opts.label = \"literal-test-1\ "'),
               equals('bare_1') )
})

test_that( "Leading string argument remains after chop.", {
  expect_that( chop_params('other=\"FALSE\", literal= TRUE'),
               equals('other=\"FALSE\"') )
  expect_that( chop_params('other=\"FALSE\", opts.label=\"literal"'),
               equals('other=\"FALSE\"') )
})

test_that( "Only trailing literals get chopped.", {
  expect_that( chop_params('literal=TRUE, literal= TRUE'),
               equals('literal=TRUE') )
  expect_that( chop_params('opts.label=\"literal\", literal= TRUE'),
               equals('opts.label=\"literal\"') )
  expect_that( chop_params('literal=TRUE, opts.label=\"literal\"'),
               equals('literal=TRUE') )
  expect_that( chop_params('opts.label=\"literal\", opts.label=\"literal\"'),
               equals('opts.label=\"literal\"') )
  expect_that( chop_params('literal=TRUE, other=NA, literal= TRUE'),
               equals('literal=TRUE, other=NA') )
  expect_that( chop_params('opts.label=\"literal\", other=NA, literal= TRUE'),
               equals('opts.label=\"literal\", other=NA') )
  expect_that( chop_params('literal=TRUE, other=NA, opts.label=\"literal\"'),
               equals('literal=TRUE, other=NA') )
  expect_that( chop_params('opts.label=\"literal\", other=NA, opts.label=\"literal\"'),
               equals('opts.label=\"literal\", other=NA') )
})

test_that( "Name argument is treated the same as default.", {
  expect_that( chop_params('verbatim=TRUE, verbatim= TRUE', "verbatim"),
               equals('verbatim=TRUE') )
  expect_that( chop_params('opts.label=\"verbatim\", verbatim= TRUE', "verbatim"),
               equals('opts.label=\"verbatim\"') )
  expect_that( chop_params('verbatim=TRUE, opts.label=\"verbatim\"', "verbatim"),
               equals('verbatim=TRUE') )
  expect_that( chop_params('opts.label=\"verbatim\", opts.label=\"verbatim\"', "verbatim"),
               equals('opts.label=\"verbatim\"') )
  expect_that( chop_params('verbatim=TRUE, other=NA, verbatim= TRUE', "verbatim"),
               equals('verbatim=TRUE, other=NA') )
  expect_that( chop_params('opts.label=\"verbatim\", other=NA, verbatim= TRUE', "verbatim"),
               equals('opts.label=\"verbatim\", other=NA') )
  expect_that( chop_params('verbatim=TRUE, other=NA, opts.label=\"verbatim\"', "verbatim"),
               equals('verbatim=TRUE, other=NA') )
  expect_that( chop_params('opts.label=\"verbatim\", other=NA, opts.label=\"verbatim\"', "verbatim"),
               equals('opts.label=\"verbatim\", other=NA') )
})
