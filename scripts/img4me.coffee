# Description:
#   img4me is awesome
#
# Dependencies:
#   "request": "2.14.0",
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   dpritchett

request = require 'request'

module.exports = (robot) ->
  robot.pngifyText = (longText, title, msg) ->
      apiUrl = "http://api.img4me.com/?"

      request.get {url: apiUrl, qs: {text: longText}},
        (error, response, body) ->
          throw error if error

          resultUrl = response.body
          msg.send  title + resultUrl
