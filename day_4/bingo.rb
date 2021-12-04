#!/usr/bin/env ruby

seq_raw, *boards_raw = ARGF.read.split("\n\n")

seq = seq_raw.split(',')
boards = boards_raw.map do |board|
    normal = board.split("\n").map(&:split)
    [normal, normal.transpose]
end

solution = (boards[0][0][0].size..seq.size).flat_map do |moves_take|
    moves = seq.take(moves_take)
    boards.flat_map.with_index do |board,idx|
        board.flat_map.with_index do |board_ver, rot|
            board_ver.flat_map.with_index do |row, row_idx|
                {
                    moves: moves_take,
                    board_major: idx,
                    board_minor: rot,
                    row_or_column: row_idx
                } if (row - moves).empty?
            end.compact
        end
    end
end

s_parts = [
    solution.first,
    solution.uniq do |s| s.fetch(:board_major) end.last
].map.with_index do |s, part_idx|
    board, rot, row, moves_take = s.values_at(:board_major, :board_minor, :row_or_column, :moves)
    moves = seq.take(moves_take)
    winning_row, *the_rest = boards[board][rot].rotate(row)

    swiss_cheesed = the_rest.flat_map do |row|
        row - moves
    end

    [
        part_idx,
        swiss_cheesed.map(&:to_i).sum * moves.last.to_i
    ]
end

s_parts.each do |part_idx, final_score|
    puts "part #{part_idx.succ} solution is #{final_score}"
end