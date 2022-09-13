# frozen_string_literal: true

require_relative '../tic_tac_toe'

describe Board do
  subject(:game_board) { Board.new } # new board with empty player states

  describe '#check_win' do
    context 'when there is a valid win state for player 1' do
      before do
        game_board.player_states[0] = 0b000000111
      end

      it 'returns 1' do
        expect(game_board.check_win).to eq(1)
      end
    end

    context 'when there is a valid win state for player 2' do
      before do
        game_board.player_states[1] = 0b000000111
      end

      it 'returns -1' do
        expect(game_board.check_win).to eq(-1)
      end
    end

    context 'when there is not a valid win state' do
      it 'returns 0' do
        expect(game_board.check_win).to eq(0)
      end
    end
  end

  describe '#make_move' do
    context 'when player 1 chooses space 1' do
      it 'player state 0 updates to 0b000000001' do
        space = 1
        player = 1
        game_board.make_move(player - 1, space - 1)
        expect(game_board.player_states[0]).to eq(0b00000001)
      end
    end

    context 'when player 2 chooses space 3' do
      it 'player state 1 updates to 0b000000100' do
        space = 3
        player = 2
        game_board.make_move(player - 1, space - 1)
        expect(game_board.player_states[1]).to eq(0b00000100)
      end
    end

    context 'when player 2 chooses space 1 and then chooses space 9' do
      it 'player state 1 updates to 0b100000001' do
        space = 1
        player = 2
        game_board.make_move(player - 1, space - 1)

        space = 9
        game_board.make_move(player - 1, space - 1)
        expect(game_board.player_states[1]).to eq(0b100000001)
      end
    end
  end

  describe '#valid_player_number?' do
    context 'when player number is valid' do
      it 'returns true when number is 1' do
        expect(Board.valid_player_number?(1)).to be(true)
      end

      it 'returns true when number is 0' do
        expect(Board.valid_player_number?(1)).to be(true)
      end
    end

    context 'when player number is invalid' do
      it 'returns false for number greater than 1' do
        expect(Board.valid_player_number?(2)).to be(false)
      end

      it 'returns false for negative number' do
        expect(Board.valid_player_number?(-5)).to be(false)
      end
    end
  end

  describe '#valid_player_move?' do
    context 'when player number is valid' do
      it 'returns true for 0' do
        expect(Board.valid_player_move?(0)).to be(true)
      end

      it 'returns true for 8' do
        expect(Board.valid_player_move?(8)).to be(true)
      end
    end

    context 'when player number is invalid' do
      it 'returns false for -1' do
        expect(Board.valid_player_move?(-1)).to be(false)
      end

      it 'returns false for 9' do
        expect(Board.valid_player_move?(9)).to be(false)
      end

      it 'returns false for 1000' do
        expect(Board.valid_player_move?(1000)).to be(false)
      end
    end
  end

  describe '#empty_space?' do
    context 'when the space is empty' do
      it 'returns true' do
        expect(game_board.empty_space?(1)).to eq(true)
      end
    end

    context 'when the space is full' do
      before do
        game_board.player_states[0] = 0b000010000
      end
      it 'returns false' do
        expect(game_board.empty_space?(4)).to eq(false)
      end
    end
  end

  describe '#board_state' do
    context 'there are Xs on the diagonal' do
      before do
        game_board.player_states[0] = 0b100010001
      end
      it "returns ['X', ' ', ' ', ' ', 'X', ' ', ' ', ' ', 'X']" do
        expect(game_board.board_state).to eq(['X', ' ', ' ', ' ', 'X', ' ', ' ', ' ', 'X'])
      end
    end

    context 'There are Xs in the first column and Os in the last column' do
      before do
        game_board.player_states[0] = 0b001001001
        game_board.player_states[1] = 0b100100100
      end

      it "returns ['X', ' ', 'O', 'X', ' ', 'O', 'X', ' ', 'O']" do
        expect(game_board.board_state).to eq(['X', ' ', 'O', 'X', ' ', 'O', 'X', ' ', 'O'])
      end
    end
  end

  describe '#prompt_user' do
    # simply prompts and gets -- unnecessary to test
  end

  describe '#display_board' do
    context 'when there is a horizontal X win in the first row' do
      before do
        game_board.player_states[0] = 0b000000111
      end

      it 'prints board correctly' do
        expected_board_output = "------------------------------\n" \
                                "|         |         |         |\n" \
                                "|    X    |    X    |    X    |\n" \
                                "|         |         |         |\n" \
                                "------------------------------\n" \
                                "|         |         |         |\n" \
                                "|         |         |         |\n" \
                                "|         |         |         |\n" \
                                "------------------------------\n" \
                                "|         |         |         |\n" \
                                "|         |         |         |\n" \
                                "|         |         |         |\n" \
                                '------------------------------'
        expect(game_board.display_board).to eq(expected_board_output)
      end
    end
  end

  describe '#play_game' do
    # method only handles user output -- does not need testing, but all methods it calls are tested
  end
end
