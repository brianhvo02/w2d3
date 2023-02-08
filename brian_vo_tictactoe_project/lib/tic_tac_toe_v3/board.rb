class Board
    def initialize(n)
        @grid = Array.new(n) { Array.new(n, "_") }
    end

    def valid?(i)
        (0 ... @grid.length).include?(i[0]) && (0 ... @grid.length).include?(i[1])
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
        (0 ... @grid.length).any? { |i| @grid.all? { |v| v[i] == mark } }
    end

    def win_diagonal?(mark)
        (0 ... @grid.length).all? { |i| @grid[i][i] == mark } || (0 ... @grid.length).all? { |i| @grid[i][@grid.length - 1 - i] == mark }
    end

    def win?(mark)
        win_row?(mark) || win_column?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.any? { |r| r.any? { |v| v == "_" } }
    end

    def legal_positions
        (0 ... @grid.length).map { |i| (0 ... @grid.length).map { |j| [i, j] } }.flatten(1).select { |pos| valid?(pos) && empty?(pos) }
    end
end