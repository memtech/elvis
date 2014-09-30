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
  registerResponder = (args) ->
    respond = (msg) ->
      if args.note?
        msg.send [args.note, msg.random(args.responses)].join(' ')
      else
        msg.send msg.random(args.responses)

    for trigger in args.triggers
      robot.hear trigger, respond

  registerResponder
    triggers:  [/burn centers/i]
    responses: [
      "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-ash3/6302_671806909512262_1147522313_n.png",
    ]

  registerResponder
    note:     'Sick burn!'
    triggers:  [/sick burn/i]
    responses: [
      "http://zerowoes.com/wp-content/uploads/2014/01/hqdefault.jpg",
    ]

  registerResponder
    triggers:  [/lolwut/i, /lol wut/i]
    responses: [
          "https://www.evernote.com/shard/s9/sh/f27bc4e3-f3e0-43ec-9db7-5bd16bdc0ffc/8f7d6ab7160aa6704fbd22ed43f9a315/deep/0/elvis-lol-wut.png",
          "https://www.evernote.com/shard/s9/sh/f27bc4e3-f3e0-43ec-9db7-5bd16bdc0ffc/8f7d6ab7160aa6704fbd22ed43f9a315/deep/0/elvis-lol-wut.png",
          "https://www.evernote.com/shard/s9/sh/f27bc4e3-f3e0-43ec-9db7-5bd16bdc0ffc/8f7d6ab7160aa6704fbd22ed43f9a315/deep/0/elvis-lol-wut.png",
          "http://lolwut.com/layout/lolwut.jpg"
    ]

  registerResponder
    note:     'RocketFuel!'
    triggers:  [
      /(rocket fuel|rocketfuel)/i,
      /(RF | RF|^RF)/]
    responses: [
      "https://pbs.twimg.com/media/Bt49KjPCUAABmjS.jpg",
      "https://pbs.twimg.com/media/Btp4KJAIAAA-QzT.jpg",
      "https://pbs.twimg.com/media/BtpMnQCCQAAJllq.jpg",
      "https://pbs.twimg.com/media/BsSO4ODCYAALup7.jpg",
      "https://pbs.twimg.com/media/BVa-YGHCcAAJOfg.jpg",
      "https://pbs.twimg.com/media/Bt9sYOKIYAAveEd.jpg",
      "https://pbs.twimg.com/media/BL2A1NECAAAGXvU.jpg",
      "http://www.gorocketfuel.com/sites/282/uploaded/images/10565013_10152643242707363_7272254102583821991_n_1.jpg",
      "https://pbs.twimg.com/media/BxCdNhgCYAAQIa6.png",
      "https://pbs.twimg.com/media/Bt9sYOKIYAAveEd.jpg",
      "http://i.imgur.com/S2qngvc.jpg",
      "http://i.imgur.com/DB0qC4d.jpg" ]
