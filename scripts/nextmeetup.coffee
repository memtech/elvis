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
      .query(keyword: msg.match[1])
      .get() (err, res, body) ->
        if err
          msg.send "Calendar API error: #{err}"
        else
          if meetup = JSON.parse(body).meetups[0]
            time = new Date(meetup.time)
            resp = "#{meetup.name}\n"
            resp += "#{time.toLocaleDateString()} #{time.toLocaleTimeString()}\n"
            resp += "#{meetup.venue.name} \n" if meetup.venue?
            resp += meetup.event_url
            msg.send resp
          else
            msg.send "Sorry, couldn't find that meetup!"
