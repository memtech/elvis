# Description:
#   Nerds Drinking Podcast links
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   elvis nerds drinking - Pull the latest post from nerdsdrinking.com
#
# Author:
#   dpritchett
#   bradmontgomery

request = require 'request'
cheerio = require 'cheerio'
url = "http://nerdsdrinking.com"

module.exports = (robot) ->

  robot.respond /nerds drinking/i, (msg) ->
    request "#{url}", (error, response, body)->
      throw error if error
      $ = cheerio.load(body)

      post  = $("article").toArray()[0]
      title = $(post).find("header h1 a")

      msg.send "#{title.text()} >> #{title.attr('href')}"

  robot.respond /literally/i, (msg) ->
    msg.send "http://nerdsdrinking.com/literal.mp3"

  
robot.respond /Wiseacre/i,(msg) -> 
    msg.send "Wiseacre - The UnOfficial beer of the Nerds Drinking Podcast."