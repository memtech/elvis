# Description:
#   welcome back to kindergarten
#
# Commands:
#   hubot say i hate myself in #memtech

module.exports = (robot) ->
  enabled = ->
    process.env.OZ_ENABLED is 'true'

  homeBase = '#MemtechBot'

  sayIn = (channel, text) ->
    envelope = { room: channel }
    robot.send envelope, text

  robot.respond /say (.*) in (#?\w+)/i, (msg) ->
    return msg.send "I'm not playing that game right now." unless enabled()

    channel  = msg.match[2]
    channel  = "#" + channel unless channel[0] is '#'
    text     = msg.match[1]
    offender = msg.message.user.name

    tattle = "User #{offender} forced me to say \"#{text}\" in #{channel}"
    msg.send tattle

    sayIn homeBase, tattle
    sayIn channel,  text
