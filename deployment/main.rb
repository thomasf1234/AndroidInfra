#!/usr/bin/env ruby

case ARGV[0]
  when "start"
    STDOUT.puts "called start"
  when "stop"
    STDOUT.puts "called stop"
  when "restart"
    STDOUT.puts "called restart"
  else
    STDOUT.puts "Unknown"
end
