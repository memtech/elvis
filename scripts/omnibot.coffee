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
    console.log "Omnibot loaded"

  #########################
  # Trigger key management
  #########################
  
 # return the trigger registry
  readTriggers = ->
    robot.brain.get("OMNIBOT_TRIGGERS")

  # overwrite the trigger registry
  setTriggers = (triggers) ->
    robot.brain.set("OMNIBOT_TRIGGERS", triggers)
    readTriggers()

  # drop a single trigger and its response from the registry
  removeTrigger = (trigger, callback) ->
    masked = maskTrigger(trigger)
    setTriggers [t for t in readTriggers if (t is not trigger and t is not masked)]
    robot.brain.remove masked
    robot.brain.remove trigger
    callback() if callback?

  # prepend OBT- to all triggers so they don't stomp on other db keys
  maskTrigger = (trigger) ->
    matcher = /^OBT/
    if trigger is null
      null
    else if matcher.test(trigger)
      trigger
    else
      "OBT-#{trigger}"

  # read all triggers from DB on boot
  loadTriggers = ->
    console.log "initializing omnibot"

    triggers = readTriggers()
    triggers = setTriggers([]) if triggers is null

    console.log "triggers: #{triggers}"

    for trigger in triggers
      if trigger? and trigger != ""
        cleaned = trigger.replace(/^OBT-/, '')
        trainResponse cleaned, robot.brain.get(trigger), true
      else
        console.log "purging bad trigger #{trigger}"
        removeTrigger trigger

  # register new trigger with central list for next restart
  addNewTrigger = (trigger, response, callback) ->
    trigger  = maskTrigger(trigger)
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

      # this looks tricky cause it needs to be disabled later if the response is deleted
      robot.hear trigger, (msg) ->
        (->
          response = robot.brain.get(maskTrigger(trigger))
          # don't bother if there's no response
          if !!response
            msg.send "#{response}")()

  # listen for training instructions 
  robot.respond /respond to ?([\w .\-_,'\?!\/:]+) with ?([\w .\-_,'\?!\/\:]+)/i, (msg) ->
    trigger  = msg.match[1]
    response = msg.match[2]
    
    trainResponse trigger, response, false
    msg.send "Ok, responding to #{trigger} with #{response}"
  
  # remove old training instructions 
  robot.respond /do not respond to ?([\w .\-_,'\?!]+)/i, (msg) ->
    console.log "not responding"
    trigger  = msg.match[1]
    
    removeTrigger trigger, ->
      msg.send "Ok, forgetting about #{trigger}"
  
  ############################################
  # Sad hacks to wait for redis to connect :(
  ############################################ 
  
  setTimeout(initialize, 2000)
