require "./lib/tic_tac_toe_v3/board"
require "./lib/tic_tac_toe_v3/human_player"
require "./lib/tic_tac_toe_v3/computer_player"

class Game
    def initialize(n, **marks)
        @players = marks.map { |k, v| v ? ComputerPlayer.new(k) : HumanPlayer.new(k) }
        @board = Board.new(n)
        @current_player = @players[0]
    end

    def switch_turn
        @current_player = @players[(@players.index(@current_player) + 1) % @players.length]
    end

    def play
        while @board.empty_positions? do
            @board.print
            pos = @current_player.get_position(@board.legal_positions)
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