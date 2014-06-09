# Description:
#   Next Memtech Meetup Search
#
# Dependencies:
#   None
#
# Commands:
#   nextmeetup $search_terms - load meetups.memphistechnology.org/$search_terms
#
# Author:
#   dpritchett


base_url = "http://meetups.memphistechnology.org/"

module.exports = (robot) ->

  # Enable a looser regex if environment variable is set
  regex = /nextmeetup (.*)/i
  robot.hear regex, (msg) ->
    msg.send base_url + msg.match[1]

  robot.respond /meetup (.*)/i, (msg) ->
    msg.http("#{base_url}/calendar.json")
       .query(keyword: term)
       .get() (err, res, body) ->
         if err
           msg.send "Calendar API error: #{err}"
         else
          if meetup = JSON.parse(body).meetups[0]
            resp = meetup.name + "\n"
            resp += meetup.event_url + "\n"
            resp += meetup.venue?.name + "\n"
            resp += new Date(meetup.time).toLocaletimeString()
            msg.send resp
