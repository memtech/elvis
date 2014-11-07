# Description:
#   Tell people hubot's new name if they use the old one
#
# Commands:
#   none
#
# Author:
#   joshwlewis
#   dpritchett

module.exports = (robot) ->
  isActuallyElvis = ->
    !!(robot.name.match /elvis/i)

  robot.hear /^(memtechbot|hubot)/i, (msg) ->
    if isActuallyElvis()
      response = "Call me #{robot.name}, baby!"
      msg.reply response
      msg.tweet response
