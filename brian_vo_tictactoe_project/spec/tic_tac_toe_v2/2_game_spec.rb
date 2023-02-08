require "./lib/tic_tac_toe_v2/game"
require "./lib/tic_tac_toe_v2/board"
require "./lib/tic_tac_toe_v2/human_player"

describe "Game" do
    let(:game) { Game.new(5, :X, :O, :T) }

    describe "#initialize" do
        it "should accept a number n, and multiple marks (char) as args" do
            game
        end

        it "should set @players to be an array of HumanPlayer" do
            expect(game.instance_variable_get(:@players)[0]).to be_an_instance_of(HumanPlayer)
        end

        it "should set @board to be an instance of Board with an n x n grid" do
            board = game.instance_variable_get(:@board)
            expect(board).to be_an_instance_of(Board)
            expect(board.instance_variable_get(:@grid).length).to eq(5)
        end

        it "should set @current_player to be @players[0]" do
            expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@players)[0])
        end
    end

    describe "#switch_turn" do
        it "should switch the current_player to the next player in @players" do
            expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@players)[0])
            game.switch_turn
            game.switch_turn
            expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@players)[2])
            game.switch_turn
            expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@players)[0])
        end
    end
end