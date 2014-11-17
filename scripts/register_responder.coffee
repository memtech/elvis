# Description:
#   Image Macro Responder
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   anything!
#
# Author:
#   dpritchett
#   svpernova09
#   basedgeek
#   bkmontgomery

module.exports = (robot) ->
  ###############################
  # convenience machinery
  ###############################

  DEFAULT_CHANCE_TO_SKIP = 93 # hi joe

  messageIsDirect = (msg) ->
    msg.message.text.match(new RegExp(robot.name, 'i'))

  # roll a number from 0 to n - 1
  dieRoll = (n) ->
    n ||= 100
    Math.random() * 100

  # roll too low and you'l get skipped
  dieRollSkipsYou = (chanceToSkip) ->
    dieRoll() < +chanceToSkip

  ######################################
  # Actual listeners
  ######################################

  # register both a 'hear' listener that occasionally responds to overheard stuff
  # and also a 'respond' listener that always respond to direct input.
  robot.registerResponder = (args) ->

    # mostly ignore indirect triggers
    respondSometimes = (msg) ->
      # direct commands are already handled by respondAlways
      return if messageIsDirect(msg)

      # bail out if we don't roll high enough
      return if dieRollSkipsYou(args.chanceToSkip || DEFAULT_CHANCE_TO_SKIP)

      if args.note?
        msg.send [args.note, msg.random(args.responses)].join(' ')
      else
        msg.send msg.random(args.responses)

    # don't ignore direct requests
    respondAlways = (msg) ->
      # direct commands are already handled by respondAlways
      if args.note?
        msg.send [args.note, msg.random(args.responses)].join(' ')
      else
        msg.send msg.random(args.responses)

    for trigger in args.triggers
      robot.respond trigger, respondAlways
      robot.hear    trigger, respondSometimes

  robot.emit "register-responder-loaded"
