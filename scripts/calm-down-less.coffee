# Description:
#   Calm down
#
# Configuration:
#   HUBOT_LESS_MANATEES
#
# Commands:
#   hubot calm me | manatee me - Reply with Manatee
#   calm down | simmer down | that escalated quickly - Reply with Manatee
#   ALL CAPS | LONGCAPS - Reply with Manatee

module.exports = (robot) ->
  manatee = ->
    num = Math.floor(Math.random() * 30) + 1
    "http://calmingmanatee.com/img/manatee#{ num }.jpg"

  robot.respond /manatee|calm( me)?/i, (msg) -> msg.send manatee()

  robot.hear /calm down|simmer down|that escalated quickly/i, (msg) ->
    msg.send manatee()

  isAllCaps = (msg) ->
    text = msg.match.input
    text.toUpperCase() == text

  unless process.env.HUBOT_LESS_MANATEES
    robot.hear ///
      (\b([A-Z]{2,}\s+)([A-Z]{2,})\b)|
      (\b[A-Z]{5,}\b)
    ///, (msg) ->
        # chance to do nothing
        return unless (Math.random() * 100) > 80

        msg.send manatee() if isAllCaps(msg)
