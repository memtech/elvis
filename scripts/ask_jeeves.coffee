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
    msg.send("Not me, try asking Jeeves.")
