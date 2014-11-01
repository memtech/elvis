# Description:
#   Movie database lookups
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   elvis movie me <title> - look up a movie on IMDB
#
# Author:
#   gpspake
#   dpritchett

request = require 'request'
cheerio = require 'cheerio'
url     = "http://www.omdbapi.com/?t="

module.exports = (robot) ->

  robot.respond /movie me (.*)/i, (msg) ->
    title = msg.match[1]
    request "#{url + title}", (error, response, body)->
      deets = JSON.parse body

      if deets.Title
        output = "#{deets.Title}, #{deets.Year}. #{deets.Plot}, #{deets.Poster}"
        if deets.imdbID?
          output += " http://www.imdb.com/title/#{deets.imdbID}"
      else
        output = "Movie not found."

      msg.send output
