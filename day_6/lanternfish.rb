#!/usr/bin/env ruby

MAX_STATE = 6

popl_initial = (
  ('0'..MAX_STATE.to_s).map { |i| [i, 0] } +
    ARGF.read.strip.split(',').tally.to_a
).group_by(&:first).map do |_k, v|
  v.map(&:last).sum
end

puts(
  [80, 256].map.with_index do |days, run_number|
    popl = popl_initial.dup
    juveniles = [0,0]
    days.times do
      new_adults = juveniles[0]
      juveniles[0] = popl[0]
      popl[0] += new_adults
      juveniles.rotate!
      popl.rotate!
    end

    format(
      "part %d:\ttotal is %d (%d mature, %d juvenile; simulation ran %d simulated days)",
      run_number,
      popl.sum + juveniles.last(2).sum,
      popl.sum,
      juveniles.last(2).sum,
      days
    )
  end.join("\n")
)