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
  # Auto-response machinery
  ###############################

  registerResponder = (args) ->
    respond = (msg) ->
      # bail out if we don't roll high enough
      if args.damper?
       dieroll = (Math.random() * 100)
       return unless dieroll > +args.damper

      if args.note?
        msg.send [args.note, msg.random(args.responses)].join(' ')
      else
        msg.send msg.random(args.responses)

    for trigger in args.triggers
      robot.hear trigger, respond

  ################################
  # Configuration of responses
  ################################

  # this is the simplest example of a responder.  It hears the phrase 'sick burn' (case insensitive)
  # and it responds with one of the images from its list.  Its list is only one image long.
  #
  # 3:04 PM <dpritchett> burn centers
  # 3:05 PM <Elvis> http://en.wikipedia.org/wiki/List_of_burn_centers_in_the_United_States
  registerResponder
    triggers:  [/burn centers/i]
    responses: [
      "http://en.wikipedia.org/wiki/List_of_burn_centers_in_the_United_States",
    ]

  # this responder adds the concept of a descriptive note - flavor text for the response.
  registerResponder
    note:     'Sick burn!'
    triggers:  [/sick burn/i, /oh burn/i]
    responses: ["http://zerowoes.com/wp-content/uploads/2014/01/hqdefault.jpg"]

  # how to Elvis
  registerResponder
    note:     'How to write an elvis macro auto response:'
    triggers:  [/^elvis macros/i, /^elvis image macros/i]
    responses: ['https://github.com/memtech/elvis/blob/master/scripts/image_macro_responder.coffee']

  registerResponder
    damper:    40
    triggers:  [/lolwut/i, /lol wut/i]
    responses: [  # lazily tripled the likelihood of the first image coming back O_o
          "https://www.evernote.com/shard/s9/sh/f27bc4e3-f3e0-43ec-9db7-5bd16bdc0ffc/8f7d6ab7160aa6704fbd22ed43f9a315/deep/0/elvis-lol-wut.png",
          "https://www.evernote.com/shard/s9/sh/f27bc4e3-f3e0-43ec-9db7-5bd16bdc0ffc/8f7d6ab7160aa6704fbd22ed43f9a315/deep/0/elvis-lol-wut.png",
          "https://www.evernote.com/shard/s9/sh/f27bc4e3-f3e0-43ec-9db7-5bd16bdc0ffc/8f7d6ab7160aa6704fbd22ed43f9a315/deep/0/elvis-lol-wut.png",
          "http://lolwut.com/layout/lolwut.jpg"
    ]


  # 3:01 PM <•dpritchett> RF
  # 3:01 PM <Elvis> RocketFuel! http://i.imgur.com/S2qngvc.jpg
  registerResponder
    damper:    33
    note:     'RocketFuel!'
    triggers:  [
      /(rocket fuel|rocketfuel)/i,
      /([^A-Za-z]RF[^A-Za-z])/]
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

  # Objection!
  registerResponder
    triggers: [/objection!/i, /i object/i]
    responses: ["http://emotibot.net/pix/6186.gif"]

  # no idea dog
  registerResponder
    damper:    75
    triggers: [/have no idea/i, /has no idea/i]
    responses: ["http://littlefun.org/uploads/520be02ac856117033000007_736.jpg#.png"]

  # yeeaaahhhh
  registerResponder
    damper:     30
    note: 'yeaaaaaaaaaaaggggggahhhhhh http://stream1.gifsoup.com/view3/1369448/howard-dean-yeah-o.gif'
    triggers: [/howard dean/i, /white house/i]
    responses: ["http://objective.ytmnd.com/"]

  # yeah.
  registerResponder
    damper:     70
    note: 'yeah.'
    triggers: [/\bgoat\b/i]
    responses: ["https://www.youtube.com/watch?v=zS-tUxcnPUk",
                "http://fc09.deviantart.net/fs70/i/2010/010/1/d/Goat_roar_by_fbcota.jpg",
                "http://cdni.wired.co.uk/620x413/s_v/sexy%20goat.jpg",
                "http://www.peta.org/wp-content/uploads/2013/10/goat_2D00_list_2D00_4.jpg",
                "http://cdn.frontpagemag.com/wp-content/uploads/2014/07/angry-goat.jpg",
                "http://4.bp.blogspot.com/_Sh3smLghY2g/TNKxDb091WI/AAAAAAAABMA/4M5iluTvXgY/s320/scarey+goat.jpg",
                "http://i.imgur.com/ExZGlKI.jpg",
                "http://surlygoat.com/event_fliers/2012_7_12_goat.jpg",
                "http://farm8.staticflickr.com/7452/11740562974_908faffa9f_n.jpg",
                "http://crossfitrough.com/wp-content/blogs.dir/134/files/2014/04/goat.jpg",
                "http://4.bp.blogspot.com/_Sh3smLghY2g/TNKxDb091WI/AAAAAAAABMA/4M5iluTvXgY/s320/scarey+goat.jpg"
    ]

  # what's up?
  registerResponder
    note: 'feeling a little peculiar'
    triggers: [/\b(blondes|he-man|he man)\b/i]
    responses: ["https://www.youtube.com/watch?v=eh7lp9umG2I"]

  # gandalf
  registerResponder
    note: 'fly, you fools!'
    triggers: [/\b(gandalf|hobbit|hobbits|orc|orcs|lotr|tolkein)\b/i]
    responses: ["https://www.youtube.com/watch?v=Sagg08DrO5U",
                "http://24.media.tumblr.com/tumblr_mbu6iap2uA1qc173ho4_250.gif", 
                "http://img3.wikia.nocookie.net/__cb20130106225013/lotr/images/4/40/GandalfVSBalrog.jpg",
                "https://www.youtube.com/watch?v=AGF5ROpjRAU",
                "https://www.youtube.com/watch?v=Nmn6Nl7YUa0",
                "http://i.imgur.com/lURXlc5.gif",
                "http://i.imgur.com/yHoiYig.gif",
                "http://i.imgur.com/tymo0Y3.gif",
                "http://imgur.com/XTdRiY8",
                "http://i.imgur.com/Pblxdu4.gif"
    ]

  # webring
  registerResponder
    damper:     70
    note: 'One ring to rule them all >> http://memtech.website/~dpritchett/webring_random.html >>'
    triggers: [/\b(web ring|webring)\b/i]
    responses: ["https://www.youtube.com/watch?v=fJlz6nEOT7w&t=0m44s",
                "https://www.youtube.com/watch?v=-UsrkoweVa4&t=1m25s", 
                "https://33.media.tumblr.com/tumblr_lw6wmqA3Ov1qiy0obo1_500.gif",
                "http://img1.wikia.nocookie.net/__cb20131010232524/lotr/images/3/3f/One_Ring_To_Rule_Them_All.gif"
    ]

  # IT Crowd
  registerResponder
    note: 'Hello, IT...'
    triggers: [/tried turning it off/i]
    responses: ["http://makeameme.org/media/created/Hello-IT-Have.jpg"]

# deadlift
  registerResponder
    note: "Nothin' but a peanut!"
    triggers: [/(deadlift|dead lift|squat)/i]
    responses: ["https://www.youtube.com/watch?v=ZWUcHKAj_tc",
                "https://www.youtube.com/watch?v=-4m_9FFBHcg",
                "http://media.giphy.com/media/dYgDRfc61SGtO/giphy.gif",
                "http://strongerwrestler.com/wp-content/uploads/2014/01/ArnoldPullUp.jpg",
                "http://i.imgur.com/8WZiyrc.jpg"
                ]

# snaaape
  registerResponder
    triggers: [/^(what\s?the\s?fuck|the\s?fuck|da\s?fuck|da\s?fuq)\??$/i]
    responses: ["http://img.pandawhale.com/41346-snape-dafuq-myUZ.jpeg"]

# supa hot fire
  registerResponder
    triggers: [/^elvis supa hot fire/i]
    responses: ["http://www.reactiongifs.com/r/2013/06/supa-hot-fire.gif"]
    
# yes hell yes mongo
  registerResponder
    triggers: [/mongo/i]
    responses: ["https://farm5.staticflickr.com/4107/5058343976_4a8166d349.jpg"]

# woo
  registerResponder
    triggers: [/^elvis kenny powers/i]
    responses: ["http://mrwgifs.com/wp-content/uploads/2013/12/Kenny-Powers-Flipping-Off-The-Crowd-On-The-Baseball-Field-In-Eastbound-Down.gif"]

# ryan nodding
  registerResponder
    triggers: [/^elvis ryan nodding/i]
    responses: ["http://img.pandawhale.com/84186-Ryan-from-the-office-this-gif-chsv.gif"]

# slash rocking
  registerResponder
    triggers: [/^elvis (slash|weedly|air guitar|guitar)/i]
    responses: ["http://i.kinja-img.com/gawker-media/image/upload/s--UyaIL8yf--/1934hcohpg7e0gif.gif"]

# memtech dicks
  registerResponder
    damper:    40
    triggers:  [/dick/i]
    responses: ["Dicks are never not funny http://memtech.website/~unstablereality"]

# bgswanson is heisenberg
  registerResponder
    triggers: [/^elvis (heisenberg|you're right)/i]
    responses: ["http://i.imgur.com/Erj8ka3.jpg"]

# swag
  registerResponder
    triggers:  [/swag/i]
    responses: ["http://i.imgur.com/5dXgWAp.gif",
                "http://i.imgur.com/tCTdKNm.gif",
                "http://i.imgur.com/l72ylSv.jpg"
                ]

# second breakfast
  registerResponder
    damper:   50
    triggers: [/second breakfast/i, /elevensies/i]
    responses: ["http://happycamperproject.files.wordpress.com/2013/08/tumblr_lzdbz2zhhg1qjpifao1_500.gif",
                "https://31.media.tumblr.com/d146fe65cfcf6f000c71f12f700aebe6/tumblr_n1vikwYCQO1rai2kio2_250.gif",
                "http://www.tickld.com/cdn_image_content/362308.jpg"]
