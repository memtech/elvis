# Description:
#   Get images for :emoji: and :emoticons.
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
#   ":emoji:" - Responds with an image link of said emoji, when found
#   "(emoji)" - Responds with an image link of said emoji, when found
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
    map = robot.brain.data.emoji_map
    names = for name, value of map
      console.log(name, value)
      ":#{ name }: | (#{ name })"

    msg.send process.env.LONG_TEXT_HINT
    msg.sendPrivate ||= msg.send # only IRC has sendPrivate
    msg.sendPrivate names.join("\n")

  sendEmojiUrl = (msg, name) ->
    if url = robot.brain.data.emoji_map[name]
      sendUrl(msg, name, url)
    else
      fetchEmoji msg, name, cheatUrl(name), {
        onFound: sendUrl,
        onNotfound: fetchEmoji(msg, name, hipchatUrl(name), onFound: sendUrl)
      }

  sendUrl = (msg, name, url) ->
    if url?
      robot.brain.data.emoji_map[name] = url
      msg.send(url)

  fetchEmoji = (msg, name, url, opts) ->
    robot.http(url).get() (err, res, body) ->
      if !err and res.statusCode in [200, 304]
        opts.onFound(msg, name, url) if opts.onFound
      else
        opts.onNotFound(msg, name, url) if opts.onNotFound

  cheatUrl = (name) ->
    "http://www.emoji-cheat-sheet.com/graphics/emojis/#{ name }.png"

  hipchatUrl = (name) ->
    "https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/#{ name }.png"

