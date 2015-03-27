# Description:
#   What's Brad Eating?
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot sphero ____ - Send sphero a command
#   hubot sphero help - List sphero commands
#
# Author:
#   dpritchett
#   bradmontgomery

request = require 'request'
cheerio = require 'cheerio'
url = "http://labs.dpritchett.net/api/robots/sphero/commands/"
tag = " >> live video at http://www.ustream.tv/channel/dpritchett"

module.exports = (robot) ->

  robot.respond /sphero (.*)/i, (msg) ->
    cmd = msg.match[1]
    cmdUrl = url + cmd
    request "#{cmdUrl}", (error, response, body)->
      throw error if error
      res = JSON.parse(body)
      msg.send (res.result + tag) if res.result?

  robot.respond /sphero help/i, (msg) ->
    cmdUrl = url
    request "#{cmdUrl}", (error, response, body)->
      throw error if error
      res = JSON.parse(body)
      commands = res.MCP.robots[0].commands.join(', ')
      msg.send commands
