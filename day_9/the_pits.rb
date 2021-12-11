#!/usr/bin/env ruby

side_padded_height_map =
  ARGF.map do |line|
    [10, *line.strip.split(//).map(&:to_i), 10]
  end

height_map =
  (
    [Array.new(side_padded_height_map.map(&:size).max, 10)] * 2
  ).insert(1, *side_padded_height_map)

rows, cols =
  [height_map, height_map.transpose].map do |rows_or_cols_padded|
    rows_or_cols_padded[1...-1].flat_map.with_index do |row_or_col, major_idx|
      row_or_col.each_cons(3).map.with_index do |point, minor_idx|
        [[major_idx, minor_idx], point[1]] if point[1] < point[0] && point[1] < point[2]
      end.compact
    end
  end

solution_one =
  (
    cols +
    rows.map do |coord, point|
      [coord.reverse, point]
    end
  ).tally(&:first).find_all do |_, v|
    v > 1
  end.map(&:first).map(&:last).map(&:succ).sum

puts "part 1:\t#{solution_one}"

#binding.pry