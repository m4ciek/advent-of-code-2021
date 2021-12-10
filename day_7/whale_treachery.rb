#!/usr/bin/env ruby

crabs = ARGF.read.split(',').map(&:to_i)

solutions_1 =
    Range.new(*crabs.minmax).map do |dest|
        [dest, crabs.map do |crab|
            (dest - crab).abs
        end.sum]
    end.sort do |a,b|
        b.last<=>a.last
    end

printf "part 1: the most economical route consumes %d fuel to reach position %d\n", *solutions_1.last.reverse

solutions_2 =
    Range.new(*crabs.minmax).map do |dest|
        [dest, crabs.map do |crab|
            distance = (dest - crab).abs
            (distance * distance.succ) >> 1
        end.sum]
    end.sort do |a,b|
        b.last<=>a.last
    end

printf "part 2: the most economical route consumes %d fuel to reach position %d\n", *solutions_2.last.reverse

binding.pry