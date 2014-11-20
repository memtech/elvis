# Description:
#   Jeeves handles the useful stuff
#
# Configuration:
#   none
#
# Commands:
#   none

module.exports = (robot) ->
  robot.askJeeves = (msg) ->
    if msg.envelope.room.match(/memtech$/i)
      msg.send("Not me, try asking Jeeves.")
      return true
    else
      return false
