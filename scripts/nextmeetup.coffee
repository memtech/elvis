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
