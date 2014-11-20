# Description:
#   MemphisTechnology.org links
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   elvis memtech - Pull the latest post from MemphisTechnology.org
#
# Author:
#   dpritchett
#   bradmontgomery
#   Svpernova09 blatantly stole and tweaked this

request = require 'request'
cheerio = require 'cheerio'
url = "http://www.memphistechnology.org"

module.exports = (robot) ->

  robot.respond /memtech/i, (msg) ->
    return if robot.askJeeves(msg)
    request "#{url}", (error, response, body)->
      throw error if error
      $ = cheerio.load(body)

      post  = $("article").toArray()[0]
      title = $(post).find("header h2 a")

      msg.send "#{title.text()} >> #{url}#{title.attr('href')}"
