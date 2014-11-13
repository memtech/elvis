# Description:
#   Retrieves random cat facts.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot catfact - Reply back with random cat fact.
#
# Author:
#   scottmeyer
#   joshwlewis
module.exports = (robot) ->
  robot.respond /CATFACT$/i, (msg) ->
    msg.http('http://catfacts-api.appspot.com/api/facts?number=1')
      .get() (error, response, body) ->
                # passes back the complete reponse
                response = JSON.parse(body)
                if response.success == "true"
                  fact = response.facts[0]
                  msg.send fact
                  robot.tweet fact
                else
                  msg.send "Unable to get cat facts right now."