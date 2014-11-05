# Description:
#  Elvise will make everything ok
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot make everything ok

module.exports = (robot) ->

  robot.respond /make everything ok/i, (msg) ->
    msg.send "http://make-everything-ok.com/"
