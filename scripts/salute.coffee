# Description:
#   Elvis should salute the higher ranks
#
# Commands:
#   none
#
# Author:
#   svpernova09
#   joshwlewis

module.exports = (robot) ->

  robot.respond /(major|general|colonel)\s*(\w+)/i, (msg) ->
    msg.emote salute(msg.match[1], msg.match[2])

  robot.respond /kernel\s*(\w+)/i, (msg) ->
    msg.emote salute("colonel", msg.match[1])

  capitalize = (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

  salute = (rank, name) ->
    if name
      "salutes #{ capitalize(rank) } #{ capitalize(name) }."
    else
      "salutes the #{ capitalize(rank) }."
