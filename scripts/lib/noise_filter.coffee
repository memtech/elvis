# Description
#   Prevents robot.hear from responding in quiet rooms
#
# Configuration
#   NOISY_ROOMS The rooms to allow robot.hear to work normally in.
#
# Authors
#   dpritchett
#   joshwlewis
#   vongrippen
#

slugify = require("./slugify")

noisyRooms = ((rooms) ->
  slugify(room) for room in rooms.split(',') when room
)(process.env.NOISY_ROOMS || '')

roomIsNoisy = (room) ->
  !room || (slugify(room) in noisyRooms)

module.exports = (original) ->
  (envelope, strings...) ->
    if roomIsNoisy(envelope.room) || envelope.message.text.match(///#{@robot.name}///i)
      original.call(@robot.adapter, envelope, strings...)
    else
      console.log("I'm not allowed to send '#{strings.join(', ')}' in response to '#{envelope.message.text}' here.")
