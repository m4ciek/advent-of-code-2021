#!/usr/bin/env ruby

COMMANDS = {
    'forward' =>
        ->(aim, x) do
            [0, Complex(x, x*aim)]
        end,
    'up' =>
        ->(_, x) { [-1*x, Complex(0,0)] },
    'down' =>
        ->(_, x) { [x, Complex(0,0)] }
}

aim = 0

position = [
    Complex(0,0),
    *(
        ARGF.map do |command|
            cmd_and_arg = /^([^\s]+)\s+(.+)$/.match(command)
            aim_diff, position_diff = COMMANDS.fetch(cmd_and_arg[1])[aim, cmd_and_arg[2].to_i]
            aim += aim_diff
            position_diff
        end
    )
].sum

puts position.imag * position.real