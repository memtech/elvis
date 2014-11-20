# Description:
#   Refuse to respond to .hear
#
# Configuration:
#   none
#
# Commands:
#   none
#
# Authors:
#   dpritchett

module.exports = (robot) ->
  robotNameRegex = new RegExp(robot.name, 'i')



  # whine in the log instead of .send()-ing when not directly addressed
  # Intended to break .hear() calls from library imports.
  #
  onlySendWhenAddressed = (envelope, strings...) ->
    if this.isAllowed
      this.oldSend arguments...
    else
      console.log "No auto responders! Try '#{robot.name} #{this.message.text}'"

  # replace the msg.send method with msg.onlySendWhenAddressed
  patchSend = (msgPrototype, oldSend) ->
    msgPrototype.isAllowed = () ->
      this.message.text.match(robotNameRegex) or !this.message.room.match(/memtech$/i)

    msgPrototype.oldSend = msgPrototype.send
    msgPrototype.send    = onlySendWhenAddressed
    msgPrototype.sendsWell   = true

  # Register this at runtime upon the very first overheard bit of chat
  robot.hear /(.*)/, (msg) ->
    msgProto = Object.getPrototypeOf(msg)
    return if msgProto.sendsWell

    patchSend msgProto
