# Description:
#   Define terms via Urban Dictionary
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot what is <term>?         - Searches Urban Dictionary and returns definition
#   hubot urban me <term>         - Searches Urban Dictionary and returns definition
#   hubot urban define me <term>  - Searches Urban Dictionary and returns definition
#   hubot urban example me <term> - Searches Urban Dictionary and returns example 
#
# Author:
#   Travis Jeffery (@travisjeffery)
#   Robbie Trencheny (@Robbie)
#
# Contributors:
#   Benjamin Eidelman (@beneidel)

module.exports = (robot) ->

  prune = (text) ->
    text.replace(/\s+/g, ' ').substr(0,400)

  robot.respond /(urban)( define)?( example)?( me)? (.*)/i, (msg) ->
    robot.noCanDo(msg)
    #urbanDict msg, msg.match[5], (found, entry, sounds) ->
      #if !found
        #msg.send "\"#{msg.match[5]}\" not found"
        #return
      #if msg.match[3]
        #msg.send "#{prune entry.example}"
      #else
        #msg.send "#{prune entry.definition}"

urbanDict = (msg, query, callback) ->
  msg.http("http://api.urbandictionary.com/v0/define?term=#{escape(query)}")
    .get() (err, res, body) ->
      result = JSON.parse(body)
      if result.list.length
        callback(true, result.list[0], result.sounds)
      else
        callback(false)
