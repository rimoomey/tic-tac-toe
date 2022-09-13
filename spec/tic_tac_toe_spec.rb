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
end
