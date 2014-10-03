# Description
#   Shakespeare will hurt your feelings
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   insult
#
# Author:
#   raykrueger
#   dpritchett
#
request = require 'request'
cheerio = require 'cheerio'
url = "http://www.pangloss.com/seidel/Shaker/"

module.exports = (robot) ->

  robot.respond /insult/i, (msg) ->
    request url, (error, response, body)->
      throw error if error
      $ = cheerio.load(body)
      quote = $("body font").first()
      msg.send quote.text()
