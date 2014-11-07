Twitter = require('twit')

config = {}
for key in ['consumer_key', 'consumer_secret', 'access_token', 'access_token_secret']
  config[key] = process.env["HUBOT_TWITTER_#{ key.toUpperCase() }"] || 'ABC123'

twitter = new Twitter(config)

module.exports = (robot) ->
  originalSend = robot.adapter.send

  robot.adapter.send = (envelope, messages...) ->
    originalSend.apply(robot.adapter, arguments)
    for message in messages
      tweet message

  tweet = (message) ->
    twitter.post 'statuses/update', status: message, (err, data, resp) ->
      console.log(err, data) if err

