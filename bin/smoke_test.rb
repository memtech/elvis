#!/usr/bin/env ruby

`mkdir -p ./log`
LOGFILENAME = "./log/errors.log"

def main
  start_headless_bot!

  sleep 5

  results = open(LOGFILENAME).readlines.join
  errors = results.scan(/error/i)

  if errors.any?
    puts "** FATAL! **"
    puts "Error count: #{errors.count}\n\n"
    puts results

    exit 1
  end
end

def start_headless_bot!
  puts "Starting headless bot..."
  IO::popen("./bin/hubot > #{LOGFILENAME}")
end

main
