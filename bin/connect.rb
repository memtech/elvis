#!/usr/bin/env ruby

ENV["HUBOT_IRC_SERVER"]  = "irc.freenode.net"
ENV["HUBOT_IRC_ROOMS"]   ||= "#MemTechBot"
ENV["HUBOT_IRC_NICK"]    ||= "MemtechBot"
ENV["HUBOT_IRC_UNFLOOD"] ||= "true"

system("bin/hubot -a irc --name #{ENV["HUBOT_IRC_NICK"]}")
