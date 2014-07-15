# Description:
#   What's Brad Eating?
#
# Dependencies:
#   "nodepie": "0.5.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot what's brad eating?
#
# Author:
#   dpritchett

NodePie = require("nodepie")

bradFeedUrl = "http://whatsbradeating.tumblr.com/rss"

module.exports = (robot) ->
  # serialize an object and print to console
  dump = (obj) ->
    console.log JSON.stringify(obj)

  # Given a tumblr escaped-HTML text payload, return the first image URL
  extractImage = (text) ->
    lines = text.split(";")
    console.log lines
    images = (line for line in lines when line.match(/jpg|png|gif/i))
    image  = images[0].match(/http.*(jpg|png|gif)/i)[0]
    image or "Could not find image in latest post :("

  # hit the feed URL and print out the first post's title and image
  lookupFood = (msg) ->
     msg.http(bradFeedUrl).get() (err, res, body) ->
       msg.send "Failed to look up the feed" if res.statusCode is not 200

       feed = new NodePie(body)
       try
         feed.init()
       catch e
         console.log(e)
         msg.send "Failed to parse the feed"
       try
         item = feed.getItems()[0]
         element = item.element
         dump element
         itemHTML = element.description
         imageURL = extractImage(itemHTML)
         msg.send "#{element.title} #{imageURL}"
       catch e
         console.log(e)
         msg.send "Failed to extract the feed"

  robot.hear /.*brad.*(eat|ate)/i, (msg) ->
    lookupFood(msg)
