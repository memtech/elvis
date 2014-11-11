# Description:
#   Tech camp is happening soon
#
# Dependencies:
#   "moment": "2.8.3",
#
# Configuration:
#   None
#
# Commands:
#   elvis tech camp - Display a countdown til tech camp starts

moment = require('moment')

module.exports = (robot) ->

  robot.respond /tech camp|techcamp/i, (msg) ->
    humanDate = moment('2014-11-01').calendar()
    ctaLink   = "http://techcampmemphis.com"

    console.log "TechCamp Memphis #{humanDate} >> #{ctaLink}"
