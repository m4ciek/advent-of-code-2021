#!/usr/bin/env ruby

MAX_STATE_PLUS_ONE = 7

popl_initial =
  MAX_STATE_PLUS_ONE.times.zip(Enumerator.produce { 0 }).to_h.merge(
    ARGF.read.split(',').map(&:to_i).tally
  ).values_at(*MAX_STATE_PLUS_ONE.times)

puts(
  [80, 256].map.with_index do |days, run_number|
    popl = popl_initial.dup
    juveniles = [0, 0]

    days.times do |day|
      j_cyc = day % 2
      popl_cyc = day % MAX_STATE_PLUS_ONE
      juveniles[j_cyc], popl[popl_cyc] = [popl[popl_cyc], popl[popl_cyc] + juveniles[j_cyc]]
    end

    format(
      "part %d: total is %d\n\t* %d mature\n\t* %d juvenile\n\t* simulation ran %d simulated days",
      run_number.succ,
      popl.sum + juveniles.sum,
      popl.sum,
      juveniles.sum,
      days
    )
  end.join("\n\n")
)
