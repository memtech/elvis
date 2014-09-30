# Description:
#   LOLWUT
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#  lol wut
#  lolwut
#
# Author:
#   jrgifford
#   dpritchett

images = [
          "https://www.evernote.com/shard/s9/sh/f27bc4e3-f3e0-43ec-9db7-5bd16bdc0ffc/8f7d6ab7160aa6704fbd22ed43f9a315/deep/0/elvis-lol-wut.png",
          "http://lolwut.com/layout/lolwut.jpg"
]

module.exports = (robot) ->
  sayLolwut = (msg) ->
    msg.send msg.random(images)

  robot.hear /(lolwut|lol wut)/i, sayLolwut
