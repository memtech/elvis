specs = require("./spec_helper.coffee")

specs.testFileByName 'beedogs',
  input: 'Elvis beedog me'
  output: /beedogs.com/i
