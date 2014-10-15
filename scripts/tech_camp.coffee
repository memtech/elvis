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
url = "http://free.timeanddate.com/countdown/i4den1hg/n409/cf12/cm0/cu4/ct0/cs0/ca0/cr0/ss0/cac000/cpc000/pcfff/tcfff/fs100/szw320/szh135/tatTime%20left%20to%20sumbit%20a%20TechCamp%20talk%20in/tac000/tptTime%20since%20Event%20started%20in/tpc000/mac000/mpc000/iso2014-10-15T23:59:59"

tcUrl = "http://cfp.techcampmemphis.com"

module.exports = (robot) ->

  robot.respond /tech camp/i, (msg) ->
    request url, (error, response, body)->
      throw error if error
      $ = cheerio.load(body)
      contents = [$("#r1").text(), $("#r2").text(), $(".cr").text(), tcUrl]
      output = (c.trim() for c in contents)
      console.log output
      msg.send output.join(' ')
