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
      "http://hotmeme.net/media/i/3/b/5ia-what-the-pot-plant-said-to-the-dea-agent.jpg",
    ]

    msg.send table
    robot.tweet table

    setTimeout () ->
      msg.emote "has left the building"

      setTimeout () ->
        process.exit(0)
      , 1000
    , 1000
