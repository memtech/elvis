# Description:
#   Being chill is awesome
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   dpritchett

module.exports = (robot) ->
  robot.noCanDo = (msg) ->
      userName = msg.message.user.name

      responses =
        [
         "I would prefer not to.",
         "I'm sorry #{userName}, I'm afraid I can't do that.",
         "Cake, and grief counseling, will be available at the conclusion of the test.",
        ]

      msg.send "#{msg.random(responses)} ( ͡° ͜ʖ ͡°)"
