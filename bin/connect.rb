#!/usr/bin/env ruby

ENV["HUBOT_IRC_SERVER"]  = "irc.freenode.net"
ENV["HUBOT_MUTE_ROOM_PREFIX"] = "" # weird irc hack
ENV["HUBOT_IRC_ROOMS"]   ||= "#MemTechBot"
ENV["HUBOT_IRC_NICK"]    ||= "Elvis_test"
ENV["HUBOT_IRC_UNFLOOD"] ||= "true"
ENV["LONG_TEXT_HINT"] ||= "Sending long output via PM <3"
ENV["TZ"] = "America/Chicago"

system("bin/hubot -a irc --name #{ENV["HUBOT_IRC_NICK"]}")
