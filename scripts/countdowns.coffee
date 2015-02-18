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

  daysUntil = (dateStamp) ->
    moment(dateStamp).diff(moment(), 'days')

  countdownTo = (args) ->
    robot.respond args.trigger, (msg) ->
      msg.send [
        args.title,
        "happens in #{daysUntil(args.date)} days",
        "(#{humanDate(args.date)})",
        args.link
      ].join(' ')


  ###########################
  # Countdowns!
  ###########################
  # timestamp docs: http://momentjs.com/docs/

  countdownTo
    title:    "GiveCamp Memphis"
    date:     '2015-02-20 18:00'
    link:     "http://givecampmemphis.org @ Cowork Memphis"
    trigger:  /give camp|givecamp/i

  countdownTo
    title:    "TechCamp Memphis (Actual Date TBD)"
    date:     '2015-11-01'
    link:     "http://techcampmemphis.org"
    trigger:  /tech camp|techcamp/i

  countdownTo
    title:    "Christmas"
    date:     '2014-12-25'
    trigger:  /days until christmas|christmas/i
