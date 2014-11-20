# Description:
#   Bee dogs are good for you
#
# Configuration:
#   none
#
# Commands:
#   hubot beedogs

module.exports = (robot) ->
  robotNameRegex = new RegExp(robot.name, 'i')

  onlySendWhenAddressed = (envelope, strings...) ->
    if this.message.text.match robotNameRegex
      this.oldSend arguments...
    else
      console.log "No auto responders! Try '#{robot.name} #{this.message.text}'"

  patchSend = (msgPrototype, oldSend) ->
    msgPrototype.isDirect = () ->
      this.message.text.match(robot.name) isnt null

    msgPrototype.oldSend = msgPrototype.send
    msgPrototype.send    = onlySendWhenAddressed
    msgPrototype.sendsWell   = true

  robot.hear /(.*)/, (msg) ->
    msgProto = Object.getPrototypeOf(msg)
    return if msgProto.sendsWell

    patchSend msgProto

  robot.hear /qwe/i, (msg) ->
    msg.send "rtyuiop"
