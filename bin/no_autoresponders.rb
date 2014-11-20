#!/usr/bin/env ruby

def main
  results = `grep -R "robot\.hear" ./scripts`
  errors = results.scan(/hear/i)

  if errors.any?
    puts "** FATAL! **"
    puts "Elvis is not allowed to use robot.hear! Try robot.respond."
    puts results

    exit 1
  end
end

main
