# Description:
#   Add a shared function to wrap NSFW functions to limit output
#   to certain channels/rooms

#####################
# INTERNAL STUFF
#####################

slugify = require("./slugify")

explicitRooms = ->
  explicitRoomsRaw = ("#{process.env.EXPLICIT_ROOMS || ''}").split ','
  (slugify(room) for room in explicitRoomsRaw when room.length isnt 0)

roomIsNaughty = (msg) ->
  room = slugify(msg.message.room || '')
  explicitRooms().indexOf(room) isnt -1

thisIsntIrc = (msg) ->
  room = (msg.message.room || '')
  room.indexOf('#') is -1

debug = (msg) ->
  console.log "Whitelisted rooms:\t#{explicitRooms().join(', ')}"
  console.log "Is this a naughty room?:\t#{roomIsNaughty(msg)}"
  console.log "Is this a non-IRC session?:\t#{thisIsntIrc(msg)}"

#####################
# EXPORTABLE STUFF
#####################

module.exports = safify = (msg, fn) ->
  if roomIsNaughty(msg) or thisIsntIrc(msg)
    fn()
  else
    userName = msg.message.user.name
    responses =
      [
       "I would prefer not to.",
       "I'm sorry #{userName}, I'm afraid I can't do that.",
       "Cake, and grief counseling, will be available at the conclusion of the test.",
      ]

    msg.reply "#{msg.random(responses)} [This command works in #memtechafterdark though]"
