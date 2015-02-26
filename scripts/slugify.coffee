module.exports = (robot) ->
  robot.slugify = (str) ->
    str.toLowerCase().replace(/\W+/g, " ").trim()
