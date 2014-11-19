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

  ###########################
  # plumbing
  ###########################

  humanDate = (dateStamp) ->
    moment(dateStamp).calendar()

  timeUntil = (dateStamp) ->
    moment(dateStamp).fromNow()

  countdownTo = (args) ->
    robot.respond args.trigger, (msg) ->
      msg.send [
        args.title,
        "happens #{timeUntil(args.date)}",
        "(#{humanDate(args.date)})",
        args.link
      ].join(' ')


  ###########################
  # Countdowns!
  ###########################

  countdownTo
    title:    "GiveCamp Memphis"
    date:     '2015-02-20'
    link:     "http://givecampmemphis.org"
    trigger:  /give camp|givecamp/i

  countdownTo
    title:    "TechCamp Memphis (Actual Date TBD)"
    date:     '2015-11-01'
    link:     "http://techcampmemphis.org"
    trigger:  /tech camp|techcamp/i
