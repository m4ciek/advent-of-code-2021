#!/usr/bin/env ruby

# it's not mentioned anywhere, but this all kind of depends on the input
# having an odd number of lines, or on the input being carefully
# constructed so that there are not the same number of 1s as 0s in any
# bit position

numbers = ARGF.map do |bin_as_str|
    bin_as_str.to_i(2)
end

mag = Math.log(numbers.max, 2).ceil.pred

𝛾, 𝜀 = (mag.downto(0).map do |pos|
    mask = 1 << pos
    [0, mask].rotate(
        (
            numbers.count <=> (numbers.count { |num| num&mask == 0 } << 1)
        ).succ >> 1
    )
end.transpose.map { |digits| digits.reduce(:|) })

puts 𝛾 * 𝜀