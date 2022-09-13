# frozen_string_literal: false

# Board for tic tac toe game
class Board
  attr_accessor :player_states

  WIN_STATES = [
    0b000000111,
    0b000111000,
    0b111000000,
    0b100010001,
    0b001010100,
    0b001001001,
    0b100100100,
    0b010010010
  ]

  def initialize(player_states = [0b0, 0b0])
    @player_states = player_states
  end

  # Checks state of board recorded in player_states
  def check_win
    WIN_STATES.each do |state|
      return 1 if @player_states[0] & state == state
      return -1 if @player_states[1] & state == state
    end
    0
  end

  # Records a player move in binary using the given space
  def make_move(player, space)
    current_player = player
    other_player = current_player.modulo(2)

    return unless (@player_states[other_player] & (2**space)).zero?

    @player_states[current_player] = @player_states[current_player] | (2**space)
  end

  # Class method to make sure player number is valid
  def self.valid_player_number?(player)
    player.instance_of?(Integer) && (player.zero? || player == 1)
  end

  def self.valid_player_move?(space)
    space.instance_of?(Integer) && space >= 0 && space <= 8
  end

  def empty_space?(space)
    # if intersection returns a 1, then the space is occupied already
    ((2**space) & @player_states[0]).zero? && ((2**space) & @player_states[1]).zero?
  end

  # Return array with current board spaces
  def board_state
    board_state = Array.new(9)

    (0..8).each do |power|
      if @player_states[0] & (2**power) == 2**power
        board_state[power] = 'X'
        next
      end
      if @player_states[1] & (2**power) == 2**power
        board_state[power] = 'O'
        next
      end
      board_state[power] = ' '
    end
    board_state
  end

  # Begin main -- only holds methods for terminal display
  def prompt_user(player_turn)
    puts "Player ##{player_turn + 1}!"
    puts 'What is your move? (1-9)'

    gets.chomp
  end

  def display_board
    spaces = board_state
    count = 0
    output = ''
    3.times do
      30.times { output += '-' }
      output += "\n"
      (0..2).each do |time|
        output += "|         |         |         |\n" unless time == 1

        next unless time == 1

        output += "|    #{spaces[count]}    |    #{spaces[count + 1]}    |    " \
                  "#{spaces[count + 2]}    |\n"
        count += 3
      end
    end
    30.times { output += '-' }
    output
  end

  def self.play_game
    game = Board.new

    check_win = 0
    player_turn = 0
    chosen_space = 0

    while check_win.zero?

      valid_move = false
      until valid_move
        chosen_space = prompt_user(player_turn).to_i - 1

        puts 'Invalid player number' unless Board.valid_player_move?(chosen_space)
        puts 'Someone already played here' unless game.empty_space?(chosen_space)

        valid_move = Board.valid_player_move?(chosen_space) && game.empty_space?(chosen_space)
      end

      game.make_move(player_turn, chosen_space)
      check_win = game.check_win
      puts display_board(game)
      player_turn = (player_turn + 1).modulo(2)
    end

    message = check_win == 1 ? 'Player 1 wins!' : 'Player 2 wins!'
    puts message
  end
end

# play_game
