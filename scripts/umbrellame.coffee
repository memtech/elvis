# Description:
#   Pugme is the most important thing in your life
#   Umbrellame is the second most important thing in your life
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot umbrella me - Receive an umbrella
#   umbrella bombs coming soon maybe

module.exports = (robot) ->

  robot.respond /umbrella me/i, (msg) ->
    msg.http("http://georgespake.com/umbrellame/")
      .get() (err, res, body) ->
        msg.send JSON.parse(body).umbrella