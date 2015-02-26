# Description
#   Prevents robot.hear from being triggered in safe rooms.
#
# Configuration
#   NOISY_ROOMS The rooms to allow robot.hear to work normally in.
#
# Authors
#   dpritchett
#   joshwlewis
#   vongrippen
#
module.exports = (robot) ->
  slugify = (str) ->
    str.toLowerCase().replace(/\W+/g, " ")

  noisyRoomsRaw = ("#{process.env.NOISY_ROOMS || ''}").split ','
  noisyRooms = (slugify(room) for room in noisyRoomsRaw when room.length isnt 0)

  roomIsNoisy = (room) ->
    slugify(room) in noisyRooms

  filterNoise = (originalFn) ->
    (envelope, strings...) ->
      if roomIsNoisy(envelope.room) || envelope.message.text.match(///#{robot.name}///i)
        originalFn.call(robot.adapter, envelope, strings...)
      else
        console.log("I'm not allowed to send '#{strings.join(', ')}' in response to '#{envelope.message.text}' in #{envelope.room}.")

  originalSend        = robot.adapter.send
  originalReply       = robot.adapter.reply
  robot.adapter.send  = filterNoise(originalSend)
  robot.adapter.reply = filterNoise(originalReply)
