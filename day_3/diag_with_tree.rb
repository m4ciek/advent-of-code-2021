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

def walk(tree, compare_method)
    l_size, l_tree = tree[0]
    r_size, r_tree = tree[1]

    if l_size == 0
        [ 1, *walk(r_tree, compare_method)]
    elsif r_size == 0
        [ 0, *walk(l_tree, compare_method)]
    elsif tree.size == 2
        # left is 0, right is 1
        if l_size.method(compare_method)[r_size]
            [0, *walk(l_tree, compare_method)]
        else
            [1, *walk(r_tree, compare_method)]
        end
    else
        tree
    end
end

numbers = ARGF.map do |bin_as_str|
    bin_as_str.to_i(2)
end

tree = part_by_msb(numbers)

puts (%i(> <=).map do |compare_method|
    walk(tree.last, compare_method).last
end.reduce(:*))