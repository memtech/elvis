#!/usr/bin/env ruby

`mkdir -p ./log`
LOGFILENAME = "./log/errors.log"

def acceptable_errors
  ["ECONNREFUSED", "RedisClient.on_error"]
end

def main
  run_headless_bot!

  # load up error log
  results = open(LOGFILENAME).readlines.join
  errors  = results.scan(/error.*/i)

  # prune uninteresting errors
  acceptable_errors.each do |err|
    errors.reject! { |e| e =~ Regexp.new(err, 'i') }
  end

  # bail on interesting errors
  if errors.any?
    puts "** FATAL! **"
    puts "Error count: #{errors.count}\n\n"
    puts results

    exit 1
  end
end

def run_headless_bot!
  # start
  puts "Starting headless bot..."
  process = IO::popen("./bin/hubot > #{LOGFILENAME}", 'r+')

  # wait to see if anything breaks
  sleep 5

  # die
  process.write("exit")
  process.close_write
end

main
