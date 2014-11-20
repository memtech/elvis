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
url = "https://raw.githubusercontent.com/sanseref/talkbackbot/master/talkback/quotes.txt"

module.exports = (robot) ->
  quotes = []

  # mute the response N% of the time
  randomMute = (pct_chance) ->
    (Math.random() * 100) <= pct_chance

  # load quotes cache on boot
  request url, (error, response, body)->
    throw error if error
    quotes = body.split("\n")

  robot.respond /twss|what she said/i, (msg) ->
    quote = quotes[Math.floor(Math.random()*quotes.length)]
    msg.send quote unless randomMute(0)
