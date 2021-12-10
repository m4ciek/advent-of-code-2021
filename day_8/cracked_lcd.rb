#!/usr/bin/env ruby

# okay, LEDs
#
# a:  0, 2, 3, 5, 6, 7, 8, 9
# b:  0, 4, 5, 6, 8, 9
# c:  0, 1, 2, 3, 4, 7, 8, 9
# d:  2, 3, 4, 5, 6, 8, 9
# e:  0, 2, 6, 8
# f:  0, 1, 3, 4, 5, 6, 7, 8, 9
# g:  0, 2, 3, 5, 6, 8, 9

# copy the preceding into the clipboard, then:

# [55] pry(main)> letter_to_numbers=Clipboard.paste.split("\n").map do |seg| letter, numbers = /\A# ([^:]+):\s*(.+)\z/.match(seg).captures; [letter, numbers.scan(/[[:digit:]]+/).map(&:to_i)] end
# => [["a", [0, 2, 3, 5, 6, 7, 8, 9]],
#  ["b", [0, 4, 5, 6, 8, 9]],
#  ["c", [0, 1, 2, 3, 4, 7, 8, 9]],
#  ["d", [2, 3, 4, 5, 6, 8, 9]],
#  ["e", [0, 2, 6, 8]],
#  ["f", [0, 1, 3, 4, 5, 6, 7, 8, 9]],
#  ["g", [0, 2, 3, 5, 6, 8, 9]]]
# [56] pry(main)> letter_to_numbers.flat_map do |letter, numbers| numbers.map do |number| [number, letter] end end.group_by(&:first).map do |k,v| [k,v.flat_map(&:last)] end.sort do |a,b| a.last.size<=>b.last.size end
# => [[1, ["c", "f"]],
#  [7, ["a", "c", "f"]],
#  [4, ["b", "c", "d", "f"]],
#  [5, ["a", "b", "d", "f", "g"]],
#  [3, ["a", "c", "d", "f", "g"]],
#  [2, ["a", "c", "d", "e", "g"]],
#  [9, ["a", "b", "c", "d", "f", "g"]],
#  [6, ["a", "b", "d", "e", "f", "g"]],
#  [0, ["a", "b", "c", "e", "f", "g"]],
#  [8, ["a", "b", "c", "d", "e", "f", "g"]]]
# [57] pry(main)>