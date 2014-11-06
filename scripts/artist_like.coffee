# Description:
#   Similar artists lookup
#
# Dependencies:
#   "echonest": "0.0.3"
#
# Configuration:
#   None
#
# Commands:
#   elvis arists like <artist name> - Finds artists like the artist used
#
# Author:
#   CommanderViral

API_KEY = "ECHONEST_API_KEY"
echonest = require 'echonest'

nest = new echonest.Echonest(api_key: API_KEY)

module.exports = (robot) ->

  robot.respond /artists like (.*)/i, (msg) ->
    artist = msg.match[1]
    nest.artist.similar name: artist, (error, response) ->
      if !error
        artist_list = response.artists.map (artist) -> artist.name
        output = artist_list.join(", ")
      else
        output = "Artist not found"
      msg.send output
