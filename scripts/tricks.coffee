# Description:
#   Who says you can't teach an old hound dog new tricks?
#   Elvis will do a trick to settle all of your disputes
#   Never toss a coin again.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot do a trick - Elvis attempts a trick and either succeeds or fails
     
random = (min,max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

description = [
  "a sick",
  "an insane",
  "a ballin ass",
  "a ridiculous",
  "a crazy",
  "a dangerous",
  "a mediocre",
  "a kind of lame",
  "an extreme"
]

trick = [
  "barrel roll",
  "540 backflip",
  "frontflip tailgrab",
  "juggling move",
  "360 varial heelflip",
  "motorcycle bus jump",
  "webinar",
  "yo yo trick",
  "fireball",
  "barehanded brick smash"
]

result = [
  "nails it",
  "dies",
  "fails miserably",
  "it's perfect"
]

doTrick = -> "/me attempts " + 
             description[random(0,description.length-1)] + " " + 
             trick[random(0,trick.length-1)] + " and " + 
             result[random(0,result.length-1)]

module.exports = (robot) ->

  robot.respond /do a trick/i, (msg) ->
    msg.send dotrick
