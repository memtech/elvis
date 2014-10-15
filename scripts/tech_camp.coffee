# Description:
#   Tech camp is happening soon
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   elvis tech camp

request = require 'request'
cheerio = require 'cheerio'
url = "http://free.timeanddate.com/countdown/i4den1hg/n409/cf12/cm0/cu4/ct0/cs0/ca0/cr0/ss0/cac000/cpc000/pcfff/tcfff/fs100/szw320/szh135/tatTime%20left%20to%20sumbit%20a%20TechCamp%20talk:/tac000/tptTime%20since%20Event%20started%20in/tpc000/mac000/mpc000/iso2014-10-15T23:59:59"

ctaLink = ">> http://cfp.techcampmemphis.com"

module.exports = (robot) ->

  robot.respond /tech camp/i, (msg) ->
    request url, (error, response, body)->
      throw error if error
      $ = cheerio.load(body)

      cta      = $("#r1").text()
      timeLeft = $(".cr").text()

      output   = (c.trim() for c in [cta, timeLeft, ctaLink])

      msg.send output.join(' ')
