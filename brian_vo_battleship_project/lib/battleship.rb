require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player

    def initialize(n)
        @player = Player.new()
        @board = Board.new(n)
        @remaining_misses = @board.size / 2
    end

    def start_game
        @board.place_random_ships
        puts @board.num_ships
        @board.print
    end

    def lose?
        puts "you lose" if @remaining_misses <= 0
        @remaining_misses <= 0
    end

    def win?
        puts "you win" if @board.num_ships == 0
        @board.num_ships == 0
    end

    def game_over?
        lose? || win?
    end

    def turn
        @remaining_misses -= 1 if !@board.attack(@player.get_move)
        @board.print
        puts @remaining_misses
    end
end
