class HumanPlayer
    attr_reader :mark

    def initialize(mark)
        @mark = mark
    end

    def get_position(legal_positions)
        begin
            puts "current mark: " + @mark.to_s
            puts "enter a position as two numbers separated with a space like `1 2`"
            pos = gets.chomp.split(" ").map { |c| c.to_i }
            raise ArgumentError.new("position not formatted correctly") if pos == nil || pos.length != 2
            raise ArgumentError.new("position not legal") if legal_positions.none? { |p| p[0] == pos[0] && p[1] == pos[1] }
            return pos
        rescue ArgumentError => e
            puts e
            return get_position(legal_positions)
        end
    end
end