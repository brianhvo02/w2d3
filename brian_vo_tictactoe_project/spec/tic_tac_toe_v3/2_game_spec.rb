require "./lib/tic_tac_toe_v3/game"
require "./lib/tic_tac_toe_v3/board"
require "./lib/tic_tac_toe_v3/human_player"
require "./lib/tic_tac_toe_v3/computer_player"

describe "Game" do
    let(:game) { Game.new(5, X: false, O: true) }

    describe "#initialize" do
        it "should accept a number n, a hash with a mark as a key and a computer/human boolean as a value" do
            game
        end

        it "should set @players to be an array of HumanPlayer" do
            expect(game.instance_variable_get(:@players)[0]).to be_an_instance_of(HumanPlayer)
            expect(game.instance_variable_get(:@players)[1]).to be_an_instance_of(ComputerPlayer)
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
            expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@players)[1])
            game.switch_turn
            expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@players)[0])
        end
    end
end