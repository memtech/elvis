module.exports = slugify = (str) ->
  str.toLowerCase().replace(/\W+/g, " ").trim()
