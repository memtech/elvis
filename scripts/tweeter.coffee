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
#   hubot tyo me at <twitter handle> - opt in to Yos
#   hubot don't tyo me - opt out of Yos
#   hubot tyo <username> - Yo opted in users via twitter
#
# Authors:
#   joshwlewis
#   meltheous
#   dpritchett
#

Twitter = require('twit')
config = {}
for key in ['consumer_key', 'consumer_secret', 'access_token', 'access_token_secret']
  config[key] = process.env["HUBOT_TWITTER_#{ key.toUpperCase() }"] || 'ABC123'
twitter = new Twitter(config)

module.exports = (robot) ->

  ##################
  # Tweets
  ##################

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

  robot.tweet = (status) ->
    status = deviralize(status)
    twitter.post 'statuses/update', status: status, (err, data, resp) ->
      console.log(err, data) if err

  ###########################
  # Yo!
  ###########################

  # opt in to get Yo!s
  robot.respond /tyo me at (@\w+)/i, (msg) ->
    robot.brain.data.twitterNames ||= {}

    yourTwitterHandle = msg.match[1]
    yourIrcNick       = msg.message.user.name

    robot.brain.data.twitterNames[yourIrcNick] = yourTwitterHandle

    msg.reply "Ok, I can now Yo! you at #{yourTwitterHandle}."

  # opt out of getting Yo!s
  robot.respond /don't tyo me/i, (msg) ->
    robot.brain.data.twitternames ||= {}
    yourIrcNick       = msg.message.user.name

    robot.brain.data.twitterNames[yourIrcNick] = null
    msg.reply "Ok, no more Yo! to you."

  # Yo! someone using the name on file.
  robot.respond /tyo (\w+)$/i, (msg) ->
    recipient = msg.match[1]
    user      = msg.message.user.name

    if twitterHandle = robot.brain.data.twitterNames[recipient]
      status = ".#{twitterHandle} Yo! from #{user}"
      twitter.post 'statuses/update', status: status, (err, data, resp) ->
        if err
          console.log(err, data, resp)
          msg.send("TWEETZOR ERROR!")
        else
          msg.send("Sent a Yo! to #{recipient} https://twitter.com/elvis_the_bot")
    else
      msg.send "Sorry, I don't have a Twitter handle on file for #{recipient}.  Have them register in IRC via 'Elvis yo me at <twitterHandle>'"
