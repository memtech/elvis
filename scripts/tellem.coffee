# Description:
#   Text to speech madness
#
# Dependencies:
#   none
#
# Configuration:
#   None
#
# Commands:
#   elvis tellem hello - links to a text to speech wav saying 'hello'

module.exports = (robot) ->
  baseUrl = 'http://windtalker.dpritchett.net/say/'

  robot.respond /tellem (.*)/i, (msg) ->
    words = msg.match[1].trim().split /\s+/
    msg.send baseUrl + words.join('%20')
