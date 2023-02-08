class Board
    attr_reader :size

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n
    end

    def [](pos)
        @grid[pos[0]][pos[1]]
    end

    def []=(pos, val)
        @grid[pos[0]][pos[1]] = val
    end

    def num_ships
        @grid.sum { |r| r.count { |v| v == :S } }
    end

    def attack(pos)
        if self[pos] == :S
            self[pos] = :H 
            puts "you sunk my battleship!"
            return true
        else
            self[pos] = :X
            return false
        end
    end

    def place_random_ships
        counter = 0

        while counter < @size / 4
            i = [rand(0 ... @grid.length), rand(0 ... @grid.length)]
            if self[i] != :S
                self[i] = :S
                counter += 1
            end
        end
    end

    def hidden_ships_grid
        @grid.map { |r| r.map { |v| v == :S ? :N : v } }
    end

    def self.print_grid(arr)
        arr.each { |r| puts r.join(" ") }
    end

    def cheat
        self.class.print_grid(@grid)
    end

    def print
        self.class.print_grid(hidden_ships_grid)
    end
end
