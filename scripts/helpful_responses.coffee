# Description:
#   Helpful Responses from the bot.
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
  robot.on 'register-responder-loaded', ->
    help = robot.registerHelpfulResponder

    # how to Elvis
    help
      note:     'How to write an Elvis auto response:'
      triggers:  [/macros/i, /image macros/i, /auto response/i]
      responses: ['https://github.com/memtech/elvis/blob/master/scripts/comedy_responses.coffee']

    # how to regex
    help
      triggers: [/(regex|regular expression)/i]
      responses: ["How to regex: http://www.regular-expressions.info/quickstart.html << Some people, when confronted with a problem, think \"I know, I'll use regular expressions.\" Now they have two problems. - jwz"]

    # check elvis build logs
    help
      triggers: [/build logs|build history|builds|travis/i]
      responses: ["https://travis-ci.org/memtech/elvis"]

    # Link to IRC stats
    help
      triggers: [/stats$|irc stats$/i]
      responses: ["http://www.joeferguson.me/ircstats/memtech.htm"]

    # unofficial community standards
    help
      triggers: [/CoC|community standards|code of conduct|guidelines/i]
      responses: ["https://github.com/memtech/community-guidelines/issues/1"]
