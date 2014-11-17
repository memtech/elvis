# Description:
#   Bee dogs are good for you
#
# Configuration:
#   none
#
# Commands:
#   hubot beedogs

request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
  beedogUrl = ->
    num = Math.floor(Math.random() * 39) + 1  # 0039 is the last page
    numStr = ("0000" + num).substr(-4,4)
    "http://www.beedogs.com/index_files/page#{numStr}.htm"

  beedog = (msg) ->
    request "#{beedogUrl()}", (error, response, body)->
      throw error if error
      $ = cheerio.load(body)
      images  = $("div>span>img").toArray()
      image   = msg.random(images)
      relativeUrl = $(image).attr('src')

      msg.send "http://www.beedogs.com/index_files/#{relativeUrl}"

  robot.respond /(beedog|bee dog)( me)?/i, (msg) -> beedog(msg)
