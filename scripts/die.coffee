# Description:
#   Kill the Elvis process
#
# Commands:
#   elvis die - End hubot process

module.exports = (robot) ->
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
      "♪┏(・o･)┛♪┗ ( ･o･) ┓♪",
    ]

    msg.send table
    robot.tweet table

    setTimeout () ->
      msg.emote "has left the building"

      setTimeout () ->
        process.exit(0)
      , 1000
    , 1000
