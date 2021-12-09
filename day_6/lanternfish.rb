#!/usr/bin/env ruby

MAX_STATE = 7

FISH_INIT_STATE = ARGF.read.split(',').map do |fish|
  MAX_STATE.pred - fish.to_i
end

states = [80].map do |days|
  [days, (
    (FISH_INIT_STATE.map.with_index do |this_fish, idx|
      print "simulating descendants of fish ##{idx}: "
      days.times.reduce([[this_fish]]) do |s, _i|
        puts "generation #{_i}; population size: #{s.last.size}"
        s << s.last.flat_map do |old_fish|
          fish = old_fish.succ
          if (fish % MAX_STATE).zero? && fish.positive?
            [fish, -2]
          else
            fish
          end
        end
      end
    end)
  )]
end

#  format('after %d days, population is %d', days, states.last.count)
#end.join("\n"))

binding.pry