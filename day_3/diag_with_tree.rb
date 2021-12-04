#!/usr/bin/env ruby

def part_by_msb(numbers, mask = 1 << Math.log(numbers.max, 2))
    if mask > 0
        count_tree_pairs =
            numbers.group_by do |num|
                num & mask
            end.values_at(0, mask).map do |v|
                if v
                    part_by_msb(v, mask >> 1)
                else
                    [0, []]
                end
            end
        # trees unused here
        counts, trees = count_tree_pairs.transpose
        [counts.sum, count_tree_pairs]
    else
        [1, numbers]
    end
end

def walk((l_size, l_tree), (r_size, r_tree), compare_method)
    digit, go =
        if l_size > 0 && (r_size == 0 || l_size.method(compare_method)[r_size])
            [0, l_tree]
        else
            [1, r_tree]
        end

    [digit, *(go.size == 2 ? walk(*go, compare_method) : go)]
end

numbers = ARGF.map do |bin_as_str|
    bin_as_str.to_i(2)
end

tree = part_by_msb(numbers)

puts (%i(> <=).map do |compare_method|
    walk(*tree.last, compare_method).last
end.reduce(:*))