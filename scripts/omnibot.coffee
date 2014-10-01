# Description:
#   Teach Elvis to respond to anything
#
# Commands:
#   Elvis respond to hello with world!
#   Elvis Ok, responding to hello with world!
#   Elvis responses for <trigger> see what responses a trigger has

module.exports = (robot) ->
  initialize = ->
    loadTriggers()

  #########################
  # Trigger key management
  #########################
  
  readTriggers = ->
    robot.brain.get("OMNIBOT_TRIGGERS")

  setTriggers = (triggers) ->
    robot.brain.set("OMNIBOT_TRIGGERS", triggers)
    readTriggers()

  removeTrigger = (trigger, callback) ->
    setTriggers [t for t in readTriggers if t is not trigger]
    robot.brain.remove trigger
    callback()

  loadTriggers = ->
    console.log "initializing omnibot"

    triggers = readTriggers()
    triggers = setTriggers([]) if triggers is null

    console.log "triggers: #{triggers}"

    for trigger in triggers
      trainResponse trigger, robot.brain.get(trigger), true

  # register new trigger with central list for next restart
  addNewTrigger = (trigger, response, callback) ->
    triggers = readTriggers()
    triggers.push(trigger) if trigger not in triggers
    setTriggers(triggers)
    robot.brain.set(trigger, response)
    callback() if callback?

  ######################################## 
  # Response training
  ######################################## 
  
  # commit a desired challenge/response to memory
  trainResponse = (trigger, response, initializing) ->
    alreadyLoaded = trigger in readTriggers()

    addNewTrigger trigger, response, ->
      return if alreadyLoaded and !initializing

      robot.hear trigger, (msg) ->
        response = -> (robot.brain.get trigger) or ""
        msg.send (-> response())()

  # remove a stored response
  purgeResponse = (trigger) ->
    robot.brain.remove trigger
    msg.send "Ok, no longer responding to #{trigger}"

  # listen for training instructions 
  robot.hear /^respond to ?([\w .\-_,'\?!]+) with ?([\w .\-_,'\?!]+)/, (msg) ->
    trigger  = msg.match[1]
    response = msg.match[2]
    
    trainResponse trigger, response, false
    msg.send "Ok, responding to #{trigger} with #{response}"
  
  # remove old training instructions 
  robot.hear /^do not respond to ?([\w .\-_,'\?!]+)/, (msg) ->
    trigger  = msg.match[1]
    
    removeTrigger trigger, ->
      msg.send "Ok, forgetting about #{trigger}"
  
  ############################################
  # Sad hacks to wait for redis to connect :(
  ############################################ 
  
  setTimeout(initialize, 2000)
