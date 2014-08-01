# Description:
#   ROCKET FUEL
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#  rocket fuel
#  rocketfuel
#  RF
#
# Author:
#   jrgifford
#   dpritchett

images = [
  "https://pbs.twimg.com/media/Bt49KjPCUAABmjS.jpg",
  "https://pbs.twimg.com/media/Btp4KJAIAAA-QzT.jpg",
  "https://pbs.twimg.com/media/BtpMnQCCQAAJllq.jpg",
  "https://pbs.twimg.com/media/BsSO4ODCYAALup7.jpg",
  "https://pbs.twimg.com/media/BVa-YGHCcAAJOfg.jpg",
  "https://pbs.twimg.com/media/BL2A1NECAAAGXvU.jpg"
  ]

module.exports = (robot) ->
  robot.hear /(rocket fuel|rocketfuel|rf)/i, (msg) ->
    msg.send msg.random images
