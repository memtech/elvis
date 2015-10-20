# Description:
#   Pull top 4 images from a subreddit by name
#
# Dependencies
#   request
#
# Commands:
#   hubot reddit bomb aww - Post images from /r/aww
#
# Authors:
#   dpritchett

request = require("request")

module.exports = (robot) ->
  extractImageFromPost = (redditPost) ->
    try
      redditPost.data.preview.images[0].source.url
    catch
      ""

  getSubredditImages = (subReddit, msg) ->
    sourceURL = "https://www.reddit.com/r/#{subReddit}/top.json?sort=top&t=day"

    console.log "Polling #{sourceURL}"

    request sourceURL, (error, response, body)->
         throw error if error
         parsed = JSON.parse(body)

         console.log "Extracting images from subreddit JSON"
         posts = parsed.data.children
         images = (extractImageFromPost(post) for post in posts)

         console.log "First hit: #{images[0]}"

         msg.reply images[0..4].join(" ")

  robot.respond /reddit bomb (.*)/i, (msg) ->
    subReddit = msg.match[1]
    getSubredditImages subReddit, msg
