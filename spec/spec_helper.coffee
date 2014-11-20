expect = require("chai").expect
path   = require("path")
Robot  = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage

module.exports =
  testFileByName: (filename, args) ->
    describe "beedogs lookup", ->
      robot   = undefined
      user    = undefined
      adapter = undefined

      beforeEach (done) ->

        # create new robot, without http, using the mock adapter
        robot = new Robot(null, "mock-adapter", false, "Elvis")
        robot.adapter.on "connected", ->

          # load the module under test and configure it for the
          require("../scripts/#{filename}.coffee")(robot)

          # create a user
          user = robot.brain.userForId "1",
            name: "mocha"
            room: "#mocha"

          adapter = robot.adapter
          done()

        robot.run()

      afterEach ->
        robot.shutdown()

      it "hears #{args.input}", (done) ->

        adapter.on "send", (envelope, strings) ->
          expect(strings[0]).match args.output
          done()

        adapter.receive(new TextMessage(user, args.input))
