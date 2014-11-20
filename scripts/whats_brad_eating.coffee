# Description:
#   What's Brad Eating?
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot what's brad eating? - Pull the latest post from http://whatsbradeating.tumblr.com
#
# Author:
#   dpritchett
#   bradmontgomery

request = require 'request'
cheerio = require 'cheerio'
url = "http://whatsbradeating.tumblr.com/"

module.exports = (robot) ->

  robot.respond /.*brad.*(eat|ate)/i, (msg) ->
    request "#{url}", (error, response, body)->
      throw error if error
      $ = cheerio.load(body)
      content = $("div.post p").toArray()
      images = $("div.post img").toArray()
      image = $(images[0]).attr("src") if images.length
      content = $(content[0]).text() if content.length
      msg.send "[What's Brad Eating?] \"#{content}\" #{image}"
