# Board for tic tac toe game
class Board
  attr_reader :els

  def initialize
    @els = {}
  end
end

# Square meant to hold a place in tic-tac-toe board
class Square
  attr_accessor :state

  def initialize(state = '')
    @state = state
  end
end

game_board = Board.new

(1..3).each do |left_index|
  (1..3).each do |right_index|
    box = Square.new
    game_board.els["#{left_index}, #{right_index}"] = box
  end
end

game_board.els.each { |hash| p hash }
