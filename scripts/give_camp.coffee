# Description:
#   Give camp is happening soon
#
# Dependencies:
#   "moment": "2.8.3",
#
# Configuration:
#   None
#
# Commands:
#   elvis give camp - Display a countdown til givecamp starts

moment = require('moment')

module.exports = (robot) ->

  robot.respond /give camp|givecamp/i, (msg) ->
    humanDate = moment('2015-02-20').fromNow()
    ctaLink   = "http://givecampmemphis.org"

    console.log "GiveCamp Memphis #{humanDate} >> #{ctaLink}"
