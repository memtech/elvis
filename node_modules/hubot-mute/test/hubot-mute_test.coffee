chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'mute', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
      listeners: []

    require('../src/hubot-mute')(@robot)

  it 'registers a respond listener for "mute list"', ->
  	expect(@robot.respond).to.have.been.calledWith(/mute list$/i)

  it 'registers a respond listener for "mute|unmute (all|channel)"', ->
    expect(@robot.respond).to.have.been.calledWith(/(mute|unmute) (all|[\#]?[\S]+)$/i)
  it 'registers a respond listener for "mute|unmute"', ->
    expect(@robot.respond).to.have.been.calledWith(/(mute|unmute)$/i)

  it 'registers a catch all listener for ".*"', ->
    expect(@robot.hear).to.have.been.calledWith(/(.*)$/i)
