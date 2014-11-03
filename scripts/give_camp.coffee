# Description:
#   Give camp is happening soon
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   elvis give camp - Display a countdown til givecamp starts

request = require 'request'
cheerio = require 'cheerio'
url = "http://free.timeanddate.com/countdown/i4den1hg/n409/cf12/cm0/cu4/ct0/cs0/ca0/cr0/ss0/cac000/cpc000/pcfff/tcfff/fs100/szw320/szh135/tatDays%20until%20GiveCamp:/tac000/tptTime%20since%20Event%20started%20in/tpc000/mac000/mpc000/iso2015-02-20T18:00:00"

ctaLink = ">> http://givecampmemphis.org"

module.exports = (robot) ->

  robot.respond /give camp|givecamp/i, (msg) ->
    request url, (error, response, body)->
      throw error if error
      $ = cheerio.load(body)

      cta      = $("#r1").text()
      timeLeft = $(".cr").text()

      output   = (c.trim() for c in [cta, timeLeft, ctaLink])

      msg.send output.join(' ')
