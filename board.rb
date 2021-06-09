# frozen_string_literal: true

# puts " 1 | 2 | 3 "
# puts "---+---+---"
# puts " 4 | 5 | 6 "
# puts "---+---+---"
# puts " 7 | 8 | 9 "



def show_board(board)
  puts ""
  puts " #{board[0][0]} | #{board[0][1]} | #{board[0][2]} "
  puts "---+---+---"
  puts " #{board[1][0]} | #{board[1][1]} | #{board[1][2]} "
  puts "---+---+---"
  puts " #{board[2][0]} | #{board[2][1]} | #{board[2][2]} "
end

board = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

show_board(board)
board[1][1] = "X"
board[2][0] = "O"
show_board(board)

