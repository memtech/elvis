#!/usr/bin/env ruby

ENV["HUBOT_IRC_SERVER"]  = "irc.freenode.net"
ENV["HUBOT_MUTE_ROOM_PREFIX"] = "" # weird irc hack
ENV["HUBOT_IRC_ROOMS"]   ||= "#MemTechBot"
ENV["HUBOT_IRC_NICK"]    ||= "Elvis_test"
ENV["HUBOT_IRC_UNFLOOD"] ||= "true"
ENV["TZ"] = "America/Chicago"

# Load faux twitter data to keep from crashing
%w{CONSUMER_KEY CONSUMER_SECRET ACCESS_TOKEN ACCESS_TOKEN_SECRET}.each do |frag|
  ENV["HUBOT_TWITTER_#{frag}"] = "ABC123"
end

system("bin/hubot -a irc --name #{ENV["HUBOT_IRC_NICK"]}")
