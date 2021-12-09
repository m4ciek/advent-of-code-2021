#!/usr/bin/env ruby

MAX_STATE_PLUS_ONE = 7
REPORT_AT = [80, 256]

popl =
  MAX_STATE_PLUS_ONE.times.zip(Enumerator.produce { 0 }).to_h.merge(
    ARGF.read.split(',').map(&:to_i).tally
  ).values_at(*MAX_STATE_PLUS_ONE.times)

juveniles = [0, 0]

puts(
  loop.with_index.with_object([]) do |(_, day), report|
    if REPORT_AT.include?(day)
      report << format(
        "part %d: total is %d\n\t* %d mature\n\t* %d juvenile\n\t* simulation ran %d simulated days",
        report.size.succ,
        popl.sum + juveniles.sum,
        popl.sum,
        juveniles.sum,
        day
      )
    end

    break report.join("\n\n") if REPORT_AT.size == report.size

    j_cyc = day % 2
    popl_cyc = day % MAX_STATE_PLUS_ONE

    juveniles[j_cyc], popl[popl_cyc] = [
      popl[popl_cyc],
      popl[popl_cyc] + juveniles[j_cyc]
    ]
  end
)
