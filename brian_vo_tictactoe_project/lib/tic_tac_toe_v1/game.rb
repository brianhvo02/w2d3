require "./lib/tic_tac_toe_v1/board"
require "./lib/tic_tac_toe_v1/human_player"

class Game
    def initialize(player_1_mark, player_2_mark)
        @player_1 = HumanPlayer.new(player_1_mark)
        @player_2 = HumanPlayer.new(player_2_mark)
        @board = Board.new
        @current_player = @player_1
    end

    def switch_turn
        @current_player = (@current_player.eql?(@player_1) ? @player_2 : @player_1)
    end

    def play
        while @board.empty_positions? do
            @board.print
            pos = @current_player.get_position
            @board.place_mark(pos, @current_player.mark)
            if @board.win?(@current_player.mark)
                puts "victory! player #{@current_player.mark} wins"
                return
            else
                switch_turn
            end
        end
        puts "draw"
    end
end