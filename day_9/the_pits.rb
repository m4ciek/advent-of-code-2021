#!/usr/bin/env ruby

side_padded_height_map =
  ARGF.map do |line|
    (Array.new(2, 9) + line.strip.split(//).map(&:to_i)).rotate
  end

PADDED_ROW_WIDTH = side_padded_height_map.map(&:size).max

height_map = (
  Array.new(2, Array.new(PADDED_ROW_WIDTH, 9)) +
  side_padded_height_map
).rotate

rows_cols =
  [height_map, height_map.transpose].flat_map.with_index do |rows_or_cols_padded, rotate_coords|
    rows_or_cols_padded[1...-1].flat_map.with_index do |row_or_col, major_idx|
      row_or_col.each_cons(3).map.with_index do |(left, value, right), minor_idx|
        [[major_idx, minor_idx].rotate(rotate_coords), value] if value < left && value < right
      end.compact
    end
  end

pits = rows_cols.tally(&:first).select { |_, v| v > 1 }.keys

solution_one = pits.map(&:last).map(&:succ).sum

puts "part 1:\t#{solution_one}"

# totally different approach for part two.
# ah, I have it now. recursive up/down exploration with horizontal propagation. work from
# the previous solution.
#
# pits structure:
# an array where each entry is of size 2. first: coordinate pair; last: value at that point
# use the padded height_map for this

pits.map do |(col_unpadded, row_unpadded), value|
  col = col_unpadded.succ
  row = row_unpadded.succ
  #p [col,row,value,height_map[row][col]]
  #col.pred.downto(0)
  #col.succ.upto()
  #height_map[row]
  # scan the current row
  # proceed recursively in the up and down directions
end

binding.pry