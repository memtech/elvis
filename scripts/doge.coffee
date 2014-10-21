# Description
#   Creates a Doge image with your phrase
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot doge <phrase> - get a doge image with your phrase
#
# Author:
#   sushithegreat
#
# Contributor:
#   benhamill

request = require 'request'

module.exports = (robot) ->

  robot.respond /doge (.*)$/i, (msg) ->
      phrase = msg.match[1].replace(/[\s]+/g, '/')
      url = "http://dogesay.com/wow////" + phrase

      # prefetch URL to speed render
      request url, (error, response, body)->
        throw error if error

      setTimeout () ->
        msg.send url
      ,1000
