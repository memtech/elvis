# Description:
#   Add a shared function to wrap NSFW functions to limit output
#   to certain channels/rooms

module.exports = (robot) ->
  robot.safify = (msg, fn)->
    explicit_rooms = ("#{process.env.EXPLICIT_ROOMS}," || ",").split ','
    console.log explicit_rooms
    if explicit_rooms.indexOf(msg.message.room) isnt -1
        fn()
    else
        userName = msg.message.user.name
        responses =
        [
         "I would prefer not to.",
         "I'm sorry #{userName}, I'm afraid I can't do that.",
         "Cake, and grief counseling, will be available at the conclusion of the test.",
        ]

        msg.send "#{msg.random(responses)} ( ͡° ͜ʖ ͡°)"