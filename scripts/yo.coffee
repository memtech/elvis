# Description:
#   yo adrian
#
# Dependencies:
#   "request": "2.14.0",
#
# Configuration:
#   None
#
# Commands:
#  elvis yo dpritchett - sends a Yo! to dpritchett
#
# Author:
#   dpritchett

request = require 'request'

module.exports = (robot) ->
  yo = (username, msg) ->
    apiKey = process.env.YO_API_KEY || ""
    apiUrl = "http://api.justyo.co/yo/"

    request.post {url: apiUrl, form: {api_token: apiKey, username: username}},
      (error, response, body) ->
        throw error if error

        resultUrl = response.headers.location

        results = JSON.parse(response.body)
        if results.error
          msg.send "Error: #{results.error}"
        else
          msg.send results.result

  robot.respond /yo (\w+)/i, (msg) ->
    username = (msg.match[1] + ' ').trim().toLowerCase()
    yo username, msg
