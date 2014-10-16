# Description:
#   Elvis should salute the higher ranks
#
# Commands:
#   none
#
# Author:
#   svpernova09

module.exports = (robot) ->

  robot.hear /^general/i, (msg) ->
    msg.reply "/me salutes the General"

  robot.hear /^kernel/i, (msg) ->
    msg.reply "/me salutes the Colonel"

  robot.hear /^major/i, (msg) ->
    msg.reply "/me salutes Major Tom"
