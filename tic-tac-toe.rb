# Board for tic tac toe game
class Board
  attr_accessor :player1_state, :player2_state

  WIN_STATES = [
    0b111000000,
    0b000111000,
    0b000000111,
    0b100010001,
    0b001010100,
    0b100100100,
    0b001001001
  ]

  def initialize(player1_state = 0, player2_state = 0)
    @player1_state = player1_state
    @player2_state = player2_state
  end

  def check_win(player1_state, player2_state)
    WIN_STATES.each do |state|
      return 1 if player1_state & state == state
      return -1 if player2_state & state == state
    end
    0
  end
end
