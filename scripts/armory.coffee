# Description:
#   img4me is awesome
#
# Dependencies:
#   "request": "2.14.0",
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   dpritchett

request = require 'request'
crypto  = require 'crypto'

# evil rubyist here ( ͡° ͜ʖ ͡°)
String.prototype.toTitleCase = (str) ->
  this.charAt(0).toUpperCase() + this.substr(1)

module.exports = (robot) ->
  randomMd5 = ->
    n = Math.random() * 10000000000
    md5 = crypto.createHash('md5')
    md5.update n.toString()
    md5.digest 'hex'

  #################################################################
  #
  # Armory preloaders
  #
  #################################################################

  baseApiUrl = "http://us.battle.net/api/wow/"

  seedWoWRaces = () ->
    return if robot.brain.data.wowRaces?

    dataUrl = baseApiUrl + "data/character/races"
    request.get dataUrl, (error, response, body) ->
        throw error if error
        robot.brain.data.wowRaces = JSON.parse(response.body).races
        robot.emit "WoWRacesLoaded"

  seedWoWClasses = () ->
    return if robot.brain.data.wowClasses?

    dataUrl = baseApiUrl + "data/character/classes"
    request.get dataUrl, (error, response, body) ->
        throw error if error
        robot.brain.data.wowClasses = JSON.parse(response.body).classes
        robot.emit "WoWClassesLoaded"

  robot.brain.on "loaded", ->
    seedWoWRaces()
    seedWoWClasses()

  #################################################################
  #
  # Armory lookups
  #
  #################################################################

  casualInsults = [
    "http://memecrunch.com/meme/11ZS8/filthy-casual-1/image.png",
    "http://weknowmemes.com/wp-content/uploads/2013/05/you-filthy-casual-meme.jpg",
    "http://i1.kym-cdn.com/photos/images/original/000/656/057/20e.jpg",
    "http://t3.gstatic.com/images?q=tbn:ANd9GcQAmZD4Lg7r_UXgr0aDy9uTfZuWreZokdf7DAt_Pj3Jwfn46iAO",
    "http://www.quickmeme.com/img/1b/1b30c02bb03a40d20f7e435234033e2511cade2d3017bca06a8595a628bf6776.jpg",
    "http://i0.kym-cdn.com/photos/images/original/000/681/031/d9c.png",
    "http://i3.kym-cdn.com/photos/images/original/000/541/870/cd3.jpg#.png",
  ]

  getRaceById = (id) ->
    name  = (el.name for el in robot.brain.data.wowRaces when el.id is id)[0]

  getClassById = (id) ->
    name  = (el.name for el in robot.brain.data.wowClasses when el.id is id)[0]

  namePlate = (charData) ->
    [charData.name, guildString(charData)].join(' ')

  guildString = (charData) ->
    if charData.guild?
      "<#{charData.guild.name}>"

  charSheet = (charData, characterUrl) ->
    race     = getRaceById(charData.race)
    klass    = getClassById(charData.class)
    imageUrl = profileImageUrl(charData)
    "#{namePlate(charData)} Level #{charData.level} #{race} #{klass} >> #{characterUrl} | #{imageUrl}"

  avatarImageUrl = (charData) ->
    relativeUrl = charData.thumbnail
    staticsBaseUrl = "http://us.battle.net/static-render/us/"
    staticsBaseUrl + relativeUrl + "?#{randomMd5()}"

  profileImageUrl = (charData) ->
    relativeUrl = avatarImageUrl(charData).replace("-avatar.jpg", "-profilemain.jpg")

  armoryLookup = (character, realm, msg) ->
      realm     = realm.toLowerCase()
      character = character.toTitleCase()

      apiUrl       = baseApiUrl + "character/#{realm}/#{character}?fields=guild+feed"
      characterUrl = "http://us.battle.net/wow/en/character/#{realm}/#{character}/simple"

      request.get apiUrl, (error, response, body) ->
          throw error if error

          if response.statusCode is 404
            msg.send "Character not found. | #{msg.random(casualInsults)}"
          else
            charData =  JSON.parse(response.body)
            msg.send charSheet(charData, characterUrl)

  # Actual hubot trigger
  robot.respond /armory (\w+) (.*)/i, (msg) ->
    [character, realm] = [msg.match[1], msg.match[2]]
    armoryLookup character, realm, msg

  robot.respond /armory (\w+)$/i, (msg) ->
    msg.send "Try Elvis armory <character> <realm>"
