#!/usr/bin/env ruby

# fig helper
ENV["REDIS_URL"] ||= ENV["REDIS_1_PORT_6379_TCP"]

ENV["HUBOT_IRC_SERVER"]  = "irc.freenode.net"
ENV["HUBOT_MUTE_ROOM_PREFIX"] = "" # weird irc hack
ENV["HUBOT_IRC_ROOMS"]   ||= "#MemTechBot"
ENV["HUBOT_IRC_NICK"]    ||= "Elvis_#{ENV['USER']}"
ENV["HUBOT_IRC_UNFLOOD"] ||= "true"
ENV["TZ"] = "America/Chicago"

system("bin/hubot -a irc --name #{ENV["HUBOT_IRC_NICK"]}")
