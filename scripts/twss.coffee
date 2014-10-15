# Description
#   twss feminist edition
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   twss
#   that's what she said
#
# Author:
#   dpritchett
#   jessamynsmith https://github.com/jessamynsmith/talkbackbot


request = require 'request'
cheerio = require 'cheerio'
url = "https://raw.githubusercontent.com/jessamynsmith/talkbackbot/master/talkback/quotes.txt"

module.exports = (robot) ->
  quotes = []

  # load quotes cache on boot
  request url, (error, response, body)->
    throw error if error
    quotes = body.split("\n")

  robot.hear /twss|what she said/i, (msg) ->
    quote = quotes[Math.floor(Math.random()*quotes.length)]
    msg.send quote
