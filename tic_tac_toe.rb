# frozen_string_literal: true

# Board for tic tac toe game
class Board
  attr_accessor :player_states

  WIN_STATES = [
    0b111000000,
    0b000111000,
    0b000000111,
    0b100010001,
    0b001010100,
    0b100100100,
    0b001001001
  ]

  def initialize(player_states = [0, 0])
    @player_states = player_states
  end

  def check_win
    WIN_STATES.each do |state|
      return 1 if @player_states[0] & state == state
      return -1 if @player_states[1] & state == state
    end
    0
  end

  def make_move(player, space)
    current_player = player - 1
    other_player = current_player.modulo(2)

    if (@player_states[other_player] &
       2**space).zero?
      @player_states[current_player] = @player_states[current_player] | 2**space
    end
  end

  def move_validator(player, space)
    if player.class != Integer ||
       player != 1 ||
       player != 2
      return 'Invalid player number'
    end

    return 'Invalid move' if space.class != Integer || space < 1 || space > 9
  end
end

game = Board.new

puts game.check_win

game.make_move(1, 5)

puts game.player_states
