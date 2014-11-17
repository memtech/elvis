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
  robot.on 'register-responder-loaded', ->
    registerResponder = robot.registerResponder

    # how to Elvis
    registerResponder
      note:     'How to write an Elvis auto response:'
      triggers:  [/macros/i, /image macros/i, /auto response/i]
      responses: ['https://github.com/memtech/elvis/blob/master/scripts/comedy_responses.coffee']

    # how to regex
    registerResponder
      triggers: [/(regex|regular expression)/i]
      responses: ["How to regex: http://www.regular-expressions.info/quickstart.html << Some people, when confronted with a problem, think \"I know, I'll use regular expressions.\" Now they have two problems. - jwz"]
