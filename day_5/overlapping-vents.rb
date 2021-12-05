#!/usr/bin/env ruby

paths = ARGF.map do |segment|
  /^(\d+),(\d+)\s*->\s*(\d+),(\d+)$/.match(segment.strip).captures.map(&:to_i)
end

# part 1

segs = paths.flat_map do |point_to_point|
  if point_to_point.each_slice(2).to_a.transpose.map(&:uniq).map(&:size).uniq.size > 1
    if point_to_point.values_at(0,2).reduce(:==)
      Range.new(*point_to_point.values_at(1,3).minmax).map { |y| [point_to_point[0], y] }
    else
      Range.new(*point_to_point.values_at(0,2).minmax).map { |x| [x, point_to_point[1]] }
    end
  end
end.compact

printf("part one: %d\n", segs.tally.count { |_k, v| v > 1 })

# part 2

segs2 = paths.flat_map do |point_to_point|
  integer_mtd = %i[downto upto].map { |sym| Integer.instance_method(sym) }

  x_y_steps =
    point_to_point.each_slice(2).to_a.transpose.map do |p1, p2|
      integer_mtd[p1 > p2 ? 0 : 1].bind(p1)[p2]
    end

  [
    x_y_steps,
    x_y_steps.reverse
  ].map do |steps1, steps2|
    if steps1.one?
      steps1.cycle(steps2.size)
    else
      steps1
    end
  end.reduce(:zip) # I'd use transpose but it's only for Array, not Enumerator
end

printf("part two: %d\n", segs2.tally.count { |_k, v| v > 1 })