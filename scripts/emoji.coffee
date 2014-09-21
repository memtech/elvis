# Description:
#   Get images for :emoji: and (emoticons). Responds to messages like
#   ':sunglasses:' and '(allthethings)' with an appropriate image url, useful
#   for IRC clients with no emoji support. Includes both Hipchat and Campfire
#   style emoji/emoticons.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot list emoji - Responds with the list of emoji known to hubot.
#   hubot show emoticons - Responds with the list of emoticons known to hubot.
#   :emoji: - Responds with an image link of said emoji, when found.
#   (emoji) - Responds with an image link of said emoji, when found.
#
# Notes:
#   Emoji/Emoticons sourced from emoji-cheat-sheet.com and
#   hipchat-emoticons.nyh.name.
#
# Author:
#   joshwlewis
#
module.exports = (robot) ->

  # Respond to emoticons/emoji in parentheses.
  robot.hear /\(\w+\)/ig, (msg) ->
    for name in msg.match
      sendEmojiUrl(msg, name.replace(/[\(\)]/g,''))

  # Respond to emoticons/emoji in colons.
  robot.hear /\:\w+\:/ig, (msg) ->
    for name in msg.match
      sendEmojiUrl(msg, name.replace(/\:/g,''))

  # Get a list of known emoji/emoticons
  robot.respond /(list|show) (emoji|emoticon)s?/i, (msg) ->
    emojis = for name, value of robot.brain.data.emoji_map
      ":#{ name }: | (#{ name }) -- #{ value }"

    output = emojis.join("\n")
    if msg.sendPrivate
      msg.send process.env.LONG_TEXT_HINT
      msg.sendPrivate output
    else
      msg.send output

  # If the url exists in the brain for the given name, send it. Otherwise
  # check and see if it's a campfire style emoticon.
  sendEmojiUrl = (msg, name) ->
    if url = robot.brain.data.emoji_map[name]
      sendUrl(msg, name, url)
    else
      sendCampfireUrl msg, name

  # Send the emoji url and cache it in the brain if it's not there
  sendUrl = (msg, name, url) ->
    if url?
      robot.brain.data.emoji_map[name] ||= url
      msg.send(url)

  # Check to see if the name is available through campfire. If it is, send it.
  sendCampfireUrl = (msg, name) ->
    url = campfireUrl(name)
    robot.http(url).get() (err, res, body) ->
      if !err and res.statusCode in [200, 304]
        sendUrl(msg, name, url)

  # Expected url for a campfire style emoticon
  campfireUrl = (name, ext = 'png') ->
    "http://www.emoji-cheat-sheet.com/graphics/emojis/#{ name }.#{ ext }"

  # Expected url for a hipchat style emoticon
  hipchatUrl = (name, ext = 'png') ->
    "https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/#{ name }.#{ ext }"

  # Load the default (hipchat) emojis into the brain, since many can't be
  # guessed.
  robot.brain.on "loaded", ->
    map = robot.brain.data.emoji_map ||= {}
    dataSrc = "https://raw.githubusercontent.com/henrik/hipchat-emoticons/master/emoticons.json"
    robot.http(dataSrc).get() (err, res, body) ->
      emojis = JSON.parse(body)
      for emoji in emojis
        key = emoji.shortcut.replace(/[\(\)]/g,'')
        map[key] ||= emoji.url



