require "./lib/tic_tac_toe_v1/game"
require "./lib/tic_tac_toe_v1/board"
require "./lib/tic_tac_toe_v1/human_player"

describe "Game" do
    let(:game) { Game.new(:X, :O) }

    describe "#initialize" do
        it "should accept a mark (symbol) for Player 1 and a mark (symbol) for Player 2 as args" do
            game
        end

        it "should set @player_1 to be HumanPlayer" do
            expect(game.instance_variable_get(:@player_1)).to be_an_instance_of(HumanPlayer)
        end

        it "should set @player_2 to be an instance of HumanPlayer" do
            expect(game.instance_variable_get(:@player_2)).to be_an_instance_of(HumanPlayer)
        end

        it "should set @board to be an instance of Board" do
            expect(game.instance_variable_get(:@board)).to be_an_instance_of(Board)
        end

        it "should set @current_player to be @player_1" do
            expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player_1))
        end
    end

    describe "#switch_turn" do
        it "should switch the current_player to whoever is now the current player" do
            game.switch_turn
            expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@player_2))
            game.switch_turn
            expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@player_1))
        end
    end
end