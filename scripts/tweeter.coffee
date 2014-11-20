# Description:
#   Tweet to predefined twitter account via oAuth credentials.
#
# Dependencies
#   twit
#
# Configration:
#   HUBOT_TWITTER_CONSUMER_KEY
#   HUBOT_TWITTER_CONSUMER_SECRET
#   HUBOT_TWITTER_ACCESS_TOKEN
#   HUBOT_TWITTER_TOKEN_SECRET
#
# Commands:
#   hubot tweet <phrase> - Post a tweet to the twitter account.
#
# Authors:
#   joshwlewis
#

Twitter = require('twit')
config = {}
for key in ['consumer_key', 'consumer_secret', 'access_token', 'access_token_secret']
  config[key] = process.env["HUBOT_TWITTER_#{ key.toUpperCase() }"] || 'ABC123'
twitter = new Twitter(config)

module.exports = (robot) ->

  deviralize = (text) ->
    text.replace /(^|\s)(@|#)/g, '$1'

  robot.respond /tweet (.*)/i, (msg) ->
    status = deviralize msg.match[1]
    twitter.post 'statuses/update', status: status, (err, data, resp) ->
      if err
        console.log(err, data, resp)
        msg.send("TWEETZOR Errorz!")
      else
        msg.send("OK I haz tweetz! https://twitter.com/elvis_the_bot")

  robot.respond /yo (@\w+)/i, (msg) ->
    recipient = msg.match[1]
    user = msg.message.user.name
    status = ".#{recipient} Yo! from #{user}"
    twitter.post 'statuses/update', status: status, (err, data, resp) ->
      if err
        console.log(err, data, resp)
        msg.send("TWEETZOR ERROR!")
      else
        msg.send("Sent a Yo! to #{recipient} https://twitter.com/elvis_the_bot")

  robot.tweet = (status) ->
    status = deviralize(status)
    twitter.post 'statuses/update', status: status, (err, data, resp) ->
      console.log(err, data) if err

