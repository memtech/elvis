# Description:
#   Geekblog.tv videolinks
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   elvis geekblog - Pull the latest post from geekblogtv on youtube
#
# Author:
#   dpritchett
#   bradmontgomery

request = require 'request'
cheerio = require 'cheerio'
url = "https://www.youtube.com/user/GeekBlogTV/videos"

module.exports = (robot) ->

  robot.respond /geekblog|basedgeek/i, (msg) ->
    return robot.askJeeves(msg)

    request "#{url}", (error, response, body)->
      throw error if error
      $ = cheerio.load(body)

      post  = $(".channels-content-item").toArray()[0]
      title = $(post).find("h3 a")

      msg.send "[GeekBlogTv] #{title.text()} >> http://youtube.com#{title.attr('href')}"
