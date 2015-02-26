module.exports = (robot) ->
  robot.slugify       = require('./lib/slugify')
  robot.safify        = require('./lib/safify')
  robot.dpaste        = require('./lib/dpaste')
  robot.adapter.send  = require('./lib/noise_filter')(robot.adapter.send)
  robot.adapter.reply = require('./lib/noise_filter')(robot.adapter.reply)
