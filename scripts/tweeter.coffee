Twitter = require('twit')

twitter = new Twitter(
  consumer_key:        process.env.HUBOT_TWITTER_CONSUMER_KEY
  consumer_secret:     process.env.HUBOT_TWITTER_CONSUMER_SECRET
  access_token:        process.env.HUBOT_TWITTER_ACCESS_TOKEN
  access_token_secret: process.env.HUBOT_TWITTER_ACCESS_TOKEN_SECRET
)

module.exports = (robot) ->
  originalSend = robot.adapter.send

  robot.adapter.send = (envelope, messages...) ->
    originalSend.apply(robot.adapter, arguments)
    for message in messages
      tweet message

  tweet = (message) ->
    twitter.post 'statuses/update', status: message, (err, data, resp) ->
      console.log(err, data) if err

