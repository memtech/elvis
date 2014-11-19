expect = require("chai").expect
path = require("path")
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage

describe "beedogs lookup", ->
  robot   = undefined
  user    = undefined
  adapter = undefined

  beforeEach (done) ->

    # create new robot, without http, using the mock adapter
    robot = new Robot(null, "mock-adapter", false, "Elvis")
    robot.adapter.on "connected", ->

      # only load scripts we absolutely need, like auth.coffee
      #process.env.HUBOT_AUTH_ADMIN = "1"
      #robot.loadFile path.resolve(path.join("node_modules/hubot/src/scripts")), "auth.coffee"

      # load the module under test and configure it for the
      # robot.  This is in place of external-scripts
      require("../scripts/beedogs.coffee")(robot)

      # create a user
      user = robot.brain.userForId("1",
        name: "mocha"
        room: "#mocha"
      )

      adapter = robot.adapter

      done()

    robot.run()

  afterEach ->
    robot.shutdown()

  it "looks up some bees", (done) ->
    adapter.on "send", (envelope, strings) ->
      expect(strings[0]).match /beedog/
      done()

    adapter.receive(new TextMessage(user, "elvis beedog me"))

  it "can bomb", (done) ->
    bombCount = 0

    adapter.on "send", (envelope, strings) ->
      bombCount++ if strings[0].match(/beedogs.com/)
      done() if bombCount is 4



    adapter.receive(new TextMessage(user, "elvis beedog bomb"))
