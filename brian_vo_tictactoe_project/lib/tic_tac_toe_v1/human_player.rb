class HumanPlayer
    attr_reader :mark

    def initialize(mark)
        @mark = mark
    end

    def get_position
        puts "current mark: " + @mark.to_s
        puts "enter a position as two numbers separated with a space like `1 2`"
        pos = gets.chomp.split(" ").map { |c| c.to_i }
        raise ArgumentError.new("position not formatted correctly") if pos == nil || pos.length != 2
        pos
    end
end