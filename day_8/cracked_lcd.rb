#!/usr/bin/env ruby

numbers =
  ARGF.readlines.map do |line|
    line.partition('|').values_at(0,2).map do |part|
      part.split.map(&:chars).map(&:sort)
    end
  end

solution_one = numbers.flat_map(&:last).group_by(&:size).values_at(2, 3, 4, 7).map(&:size).sum

puts "part 1: #{solution_one}"

NUMBERS = [
  %w[a b c e f g],
  %w[c f],
  %w[a c d e g],
  %w[a c d f g],
  %w[b c d f],
  %w[a b d f g],
  %w[a b d e f g],
  %w[a c f],
  %w[a b c d e f g],
  %w[a b c d f g]
]

solution_two =
  ('a'..'g').to_a.permutation.flat_map do |p|
    mapping = p.zip('a'..'g').to_h
    numbers.map do |patterns, group_of_four|
      next unless (
          NUMBERS -
          patterns.map { |pattern| mapping.values_at(*pattern).sort }
        ).empty?

      group_of_four.map do |one_of_four|
        NUMBERS.index(mapping.values_at(*one_of_four).sort)
      end
    end.compact
  end

printf(
  "part 2: %d\n",
  solution_two.map do |digits|
    digits.reverse.map.with_index { |digit, mag| digit * 10**mag }.sum
  end.sum
)
