# Description:
#   Elvis should salute the higher ranks
#
# Commands:
#   none
#
# Author:
#   svpernova09

module.exports = (robot) ->

  robot.hear /general/i, (msg) ->
    msg.emote "salutes the General"

  robot.hear /kernel|colonel/i, (msg) ->
    msg.emote "salutes the Colonel"

  robot.hear /major/i, (msg) ->
    msg.emote "salutes Major Tom"
