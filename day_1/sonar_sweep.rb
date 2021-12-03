#!/usr/bin/env ruby

depth_measurements = []

ARGF.each do |ping|
    depth_measurements << ping.to_i
end

trends = depth_measurements.each_cons(2).map { |pings| pings.reduce(:-) <=> 0 }.tally

puts trends.fetch(-1)