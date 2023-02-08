class Board
    def initialize
        @grid = Array.new(3) { Array.new(3, "_") }
    end

    def valid?(i)
        (0 ... 3).include?(i[0]) && (0 ... 3).include?(i[1])
    end

    def empty?(i)
        @grid[i[0]][i[1]] == "_"
    end

    def place_mark(i, mark)
        raise IndexError.new("index not valid") if !valid?(i)
        raise ArgumentError.new("value at index not empty") if !empty?(i)

        @grid[i[0]][i[1]] = mark
    end

    def print
        @grid.each { |r| puts r.join(" ") }
    end

    def win_row?(mark)
        @grid.any? { |r| r.all? { |v| v == mark } }
    end

    def win_column?(mark)
        (0 ... 3).any? { |i| @grid.all? { |v| v[i] == mark } }
    end

    def win_diagonal?(mark)
        (0 ... 3).all? { |i| @grid[i][i] == mark } || [ @grid[0][2], @grid[1][1], @grid[2][0] ].all? { |m| m == mark }
    end

    def win?(mark)
        win_row?(mark) || win_column?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.any? { |r| r.any? { |v| v == "_" } }
    end
end