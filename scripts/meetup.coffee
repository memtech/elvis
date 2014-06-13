# Description:
#   Memphis Technology User Groups Meetup Search
#
# Dependencies:
#   None
#
# Commands:
#   meetup|event $search_terms - Display information for the next meetup matching the $search_terms
#   link meetup|event $search_terms - Get a permanent url for the next meetup matching $search_tems
#
# Author:
#   dpritchett
#   joshwlewis


base_url = "http://meetups.memphistechnology.org/"

module.exports = (robot) ->

  robot.respond /link (event|meetup) (.*)/i, (msg) ->
    msg.send base_url + msg.match[2]

  robot.respond /(event|meetup) (.*)/i, (msg) ->
    keyword = msg.match[2]
    msg.http("#{base_url}/calendar.json")
      .query(keyword: keyword)
      .get() (err, res, body) ->
        if err
          msg.send "Calendar API error: #{err}"
        else
          if meetup = JSON.parse(body).meetups[0]
            time = new Date(meetup.time)
            resp = "#{meetup.name}: "
            resp += "#{time.toLocaleDateString()} #{time.toLocaleTimeString()} "
            resp += "@#{meetup.venue.name} " if meetup.venue?
            resp += "(#{base_url}#{escape keyword})"
            msg.send resp
          else
            msg.send "Sorry, I couldn't find a meetup matching #{keyword}."
