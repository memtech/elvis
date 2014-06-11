# Description:
#   Tell people hubot's new name if they use the old one
#
# Commands:
#   None
#
module.exports = (robot) ->
  isActuallyElvis = ->
    !!(robot.name.match /elvis/i)

  robot.hear /^(memtechbot|hubot)/i, (msg) ->
    return unless isActuallyElvis()
    response = "Call me #{robot.name}, baby!"
    response += "\nhttp://media.npr.org/programs/wesat/features/2007/aug/elvis200-ffccc2998ad02985efaaa8917b76b932b625d2b0-s6-c30.jpg"
    msg.reply(response)
    return
