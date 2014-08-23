# Description:
#   Get images for :emoji: and (emoticons)
#   Responds to messages like ':sunglasses:' and '(allthethings)' with
#   an appropriate image link, useful for IRC clients with no emoji support.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot (list|show) (emoji|emoticons) - Responds with the list of emoji known to hubot.
#   :emoji: - Responds with an image link of said emoji, when found
#   (emoji) - Responds with an image link of said emoji, when found
#
# Notes:
#   Emoji/Emoticons sourced from emoji-cheat-sheet.com and hipchat-emoticons.nyh.name 
#
# Author:
#   joshwlewis
#
module.exports = (robot) ->
  robot.brain.on "loaded", ->
    robot.brain.data.emoji_map ?= {}

  robot.hear /\(\w+\)/ig, (msg) ->
    for name in msg.match
      sendEmojiUrl(msg, name.replace(/[\(\)]/g,''))

  robot.hear /\:\w+\:/ig, (msg) ->
    for name in msg.match
      sendEmojiUrl(msg, name.replace(/\:/g,''))

  robot.respond /(list|show) (emoji|emoticon)s?/i, (msg) ->
    emojis = for name, value of robot.brain.data.emoji_map
      ":#{ name }: | (#{ name }) -- #{ value }"

    output = emojis.join("\n")
    if msg.sendPrivate
      msg.send process.env.LONG_TEXT_HINT
      msg.sendPrivate output
    else
      msg.send output

  sendEmojiUrl = (msg, name) ->
    if url = robot.brain.data.emoji_map[name]
      sendUrl(msg, name, url)
    else
      sendCampfireUrl msg, name, onNotFound: sendHipchatUrl

  sendUrl = (msg, name, url) ->
    if url?
      robot.brain.data.emoji_map[name] = url
      msg.send(url)

  fetchEmoji = (msg, name, url, opts) ->
    opts ||= {}
    robot.http(url).get() (err, res, body) ->
      if !err and res.statusCode in [200, 304]
        sendUrl(msg, name, url)
      else
        opts.onNotFound(msg, name) if opts.onNotFound

  sendCampfireUrl = (msg, name, opts) ->
    fetchEmoji msg, name, "http://www.emoji-cheat-sheet.com/graphics/emojis/#{ name }.png", opts

  sendHipchatUrl = (msg, name, opts) ->
    fetchEmoji msg, name, "https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/#{ name }.png", opts

