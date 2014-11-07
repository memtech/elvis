# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot ping - Reply with pong
#   hubot echo <text> - Reply back with <text>
#   hubot time - Reply with current time
#   hubot die - End hubot process

module.exports = (robot) ->
  robot.respond /PING$/i, (msg) ->
    msg.send "PONG"
    robot.tweet "PONG"

  robot.respond /ADAPTER$/i, (msg) ->
    msg.send robot.adapterName

  robot.respond /ECHO (.*)$/i, (msg) ->
    msg.send msg.match[1]

  robot.respond /TIME$/i, (msg) ->
    msg.send "Server time is: #{new Date()}"

  robot.respond /DIE$/i, (msg) ->
    # http://emojicons.com/table-flipping
    table = msg.random [
      "(╯°□°）╯︵ ┻━┻",
      "┬─┬ ノ( ゜-゜ノ)",
      "(╯°□°)╯︵ ┻━┻ ︵ ╯(°□° ╯)",
      "┬─┬ ︵ /(.□. \）",
      "(ﾉಥ益ಥ）ﾉ  ┻━┻",
      "(/ .□.)\ ︵╰(゜Д゜)╯︵ /(.□. \)",
      "(/¯◡ ‿ ◡)/¯ ~ ┻━┻",
      "ʕノ•ᴥ•ʔノ ︵ ┻━┻",
      "(._.) ~ ︵ ┻━┻",
    ]

    msg.send table
    robot.tweet table

    setTimeout () ->
      msg.emote "has left the building"

      setTimeout () ->
        process.exit(0)
      , 1000
    , 1000
