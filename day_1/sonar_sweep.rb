#!/usr/bin/env ruby

depth_measurements = ARGF.map(&:to_i)
trends = depth_measurements.each_cons(2).map { |pings| pings.reduce(:-) <=> 0 }.tally

puts trends.fetch(-1)