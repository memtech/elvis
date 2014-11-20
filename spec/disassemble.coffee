specs = require("./spec_helper.coffee")

specs.testFileByName 'disassemble',
  input: 'Elvis disassemble'
  output: /NO DISASSEMBLE/
