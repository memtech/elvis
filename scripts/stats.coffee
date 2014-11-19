# Description:
#   Link to IRC stats
#
# Commands:
#   elvis stats
#   elvis irc stats

module.exports = (robot) ->
  robot.respond /stats$|irc stats$/i, (msg) ->
    msg.send "http://www.joeferguson.me/ircstats/memtech.htm"
