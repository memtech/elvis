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
rootUrl = "http://knowyourmeme.com"

module.exports = (robot) ->
  prune = (text) ->
    text.replace(/\s+/g, ' ').substr(0,400)

  lookupOpts = (url) ->
    url: url
    headers:
      "User-Agent": 'memtech-Elvis'   # cheezburger hates the default UA string

  robot.respond /meme (.*)/i, (msg) ->
    terms     = msg.match[1]
    lookupUrl = "#{rootUrl}/search?q=#{terms}"
    opts      = lookupOpts(lookupUrl)

    request opts, (error, response, body)->
      throw error if error
      $ = cheerio.load(body)

      detailUrl = $(".entry_list td a").attr('href')
      detailUrl = "#{rootUrl}#{detailUrl}"
      opts = lookupOpts(detailUrl)

      request opts, (error, response, body)->
        throw error if error
        $ = cheerio.load(body)
        description = $(".bodycopy p").text()

        msg.send prune(detailUrl + " " + description)
