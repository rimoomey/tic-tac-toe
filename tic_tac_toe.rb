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
    current_player = player
    other_player = current_player.modulo(2)

    if (@player_states[other_player] &
       2**space).zero?
      @player_states[current_player] = @player_states[current_player] | 2**space
    end
  end

  def self.valid_player_number?(player)
    if player.class != Integer ||
       (player != 0 &&
       player != 1)
      puts 'Invalid player number'
      return false
    end
    true
  end

  def self.valid_player_move?(space)
    if space.class != Integer || space < 1 || space > 9
      puts 'Invalid move'
      return false
    end
    true
  end

  def empty_space?(space)
    if !(2**space & @player_states[0]).zero? || !(2**space & @player_states[1]).zero?
      puts 'Someone already played here'
      return false
    end
    true
  end

  def board_state
    board_state = Array.new(9)

    (1..9).each do |power|
      if @player_states[0] & 2**power == 2**power
        board_state[power - 1] = 'X'
      elsif @player_states[1] & 2**power == 2**power
        board_state[power - 1] = 'O'
      else
        board_state[power - 1] = ' '
      end
    end
    board_state
  end
end

def prompt_user(player_turn)
  puts "Player ##{player_turn + 1}!"
  puts 'What is your move? (1-9)'

  gets.chomp
end

def display_board(game_board)
  spaces = game_board.board_state
  count = 0
  3.times do
    30.times { print '-' }
    puts ''
    (0..2).each do |time|
      puts '|         |         |         |' unless time == 1

      if time == 1
        puts "|    #{spaces[count]}    |    #{spaces[count + 1]}    |" \
             "    #{spaces[count + 2]}    |"
        count += 3
      end
    end
  end
  28.times { print '-' }
  puts ''
end

def play_game
  game = Board.new

  check_win = 0
  player_turn = 0
  chosen_space = 0

  while check_win.zero?

    valid_move = false
    until valid_move
      chosen_space = prompt_user(player_turn).to_i

      valid_move = Board.valid_player_number?(player_turn)
      valid_move = Board.valid_player_move?(chosen_space)
      valid_move = game.empty_space?(chosen_space)
    end

    game.make_move(player_turn, chosen_space)
    check_win = game.check_win
    puts check_win
    display_board(game)
    player_turn = (player_turn + 1).modulo(2)
  end

  check_win == 1 ? 'Player 1 wins!' : 'Player 2 wins!'
end

play_game
