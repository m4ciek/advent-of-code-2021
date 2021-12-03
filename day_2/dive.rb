#!/usr/bin/env ruby

COMMANDS = {
    'forward' => Complex(1,0),
    'up' => Complex(0,-1),
    'down' => Complex(0,1)
}

position = [
    Complex(0,0),
    *(
        ARGF.map do |command|
            cmd_and_arg = /^([^\s]+)\s+(.+)$/.match(command)
            COMMANDS.fetch(cmd_and_arg[1]) * cmd_and_arg[2].to_i
        end
    )
].sum

puts position.imag * position.real