require "./lib/tic_tac_toe_v2/board"

describe "Board" do
    let(:board) { Board.new(5) }

    describe "Checkpoint - Board yet?" do
        describe "#initialize" do
            it "should accept a number n" do
                board
            end

            it "should set @grid to be a 2D array with n rows and n columns" do
                grid = board.instance_variable_get(:@grid)
                expect(grid.length).to eq(5)
                expect(grid.count { |r| r.length == 5 }).to eq(5)
            end

            it "should set all elements of @grid to '_'" do
                grid = board.instance_variable_get(:@grid)
                nil_grid = Array.new(5) { Array.new(5, "_") }
                expect(grid).to eq(nil_grid)
            end
        end

        describe "#valid?" do
            it "should accept an array containing a pair of indices in the form [row, column] representing a position on the @board" do
                board.valid?([0, 0])
            end

            context "when the specified position is valid for the board" do
                it "should return true" do
                    expect(board.valid?([ 0, 0 ])).to eq(true)
                end
            end

            context "when the specified position is NOT valid for the board" do
                it "should return false" do
                    expect(board.valid?([ 5, 5 ])).to eq(false)
                end
            end
        end

        describe "#empty?" do
            it "should accept a position as an argument" do
                board.empty?([0, 0])
            end

            context "when the specified position does NOT contain a player's mark" do
                it "should return true" do
                    expect(board.empty?([ 0, 0 ])).to eq(true)
                    
                end
            end

            context "when the specified position contains a player's mark" do
                it "should return false" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][0] = :X
                    expect(board.empty?([ 0, 0 ])).to eq(false)
                end
            end
        end

        describe "#place_mark" do
            it "should accept should accept a position and a mark (character) as arguments" do
                board.place_mark([0, 1], :X)
            end

            it "should set the given position of @grid to the given mark" do
                grid = board.instance_variable_get(:@grid)
                board.place_mark([ 0, 1 ], :X)
                expect(grid[0][1]).to eq(:X)
            end

            context "when the position is not #valid?" do
                it "should raise an error" do
                    expect { board.place_mark([ 0, 5 ], :X) }.to raise_error
                end
            end

            context "when the position is not #empty?" do
                it "should raise an error" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][1] = :X
                    expect { board.place_mark([ 0, 1 ], :X) }.to raise_error
                end
            end
        end
    end

    describe "Checkpoint - You're all winners" do
        describe "#print" do
            it "should print each row of @grid so every element in a row is separated with a space" do
                grid = board.instance_variable_get(:@grid)
                grid[1][1] = :X
                expect { board.print }.to output(/_ _ _ _ _\n_ X _ _ _\n_ _ _ _ _\n_ _ _ _ _\n_ _ _ _ _/).to_stdout 
            end
        end

        describe "#win_row?" do
            it "should accept a mark (character)" do
                board.win_row?(:X)
            end

            context "when there is a row of the given mark" do
                it "should return true" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][0] = :X
                    grid[0][1] = :X
                    grid[0][2] = :X
                    grid[0][3] = :X
                    grid[0][4] = :X

                    expect(board.win_row?(:X)).to eq(true)
                end
            end

            context "when there is NOT a row of the given mark" do
                it "should return false" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][0] = :X
                    grid[0][1] = :O
                    grid[0][2] = :X
                    grid[0][3] = :X
                    grid[0][4] = :X

                    expect(board.win_row?(:X)).to eq(false)
                end
            end
        end

        describe "#win_column?" do
            it "should accept a mark (character)" do
                board.win_column?(:X)
            end

            context "when there is a column of the given mark" do
                it "should return true" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][0] = :X
                    grid[1][0] = :X
                    grid[2][0] = :X
                    grid[3][0] = :X
                    grid[4][0] = :X

                    expect(board.win_column?(:X)).to eq(true)
                end
            end

            context "when there is NOT a column of the given mark" do
                it "should return false" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][0] = :X
                    grid[1][0] = :O
                    grid[2][0] = :X
                    grid[3][0] = :X
                    grid[4][0] = :X

                    expect(board.win_column?(:X)).to eq(false)
                end
            end
        end

        describe "#win_diagonal?" do
            it "should accept a mark (character)" do
                board.win_diagonal?(:X)
            end

            context "when there is a diagonal of the given mark" do
                it "should return true" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][0] = :X
                    grid[1][1] = :X
                    grid[2][2] = :X
                    grid[3][3] = :X
                    grid[4][4] = :X

                    expect(board.win_diagonal?(:X)).to eq(true)
                end
            end

            context "when there is NOT a diagonal of the given mark" do
                it "should return false" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][0] = :X
                    grid[1][1] = :O
                    grid[2][2] = :X
                    grid[3][3] = :X
                    grid[4][4] = :X

                    expect(board.win_diagonal?(:X)).to eq(false)
                end
            end
        end

        describe "#win?" do
            it "should accept a mark (character)" do
                board.win?(:X)
            end

            context "when there is a row, column, or diagonal of the given mark" do
                it "should return true" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][0] = :X
                    grid[1][1] = :X
                    grid[2][2] = :X
                    grid[3][3] = :X
                    grid[4][4] = :X

                    expect(board.win?(:X)).to eq(true)
                end
            end

            context "when there is NOT a row, column, or diagonal of the given mark" do
                it "should return false" do
                    grid = board.instance_variable_get(:@grid)
                    grid[0][0] = :X
                    grid[1][1] = :O
                    grid[2][2] = :X
                    grid[3][3] = :X
                    grid[4][4] = :X

                    expect(board.win?(:X)).to eq(false)
                end
            end

            it "should use Board#win_row?" do
                grid = board.instance_variable_get(:@grid)
                grid[0][0] = :X
                grid[0][1] = :X
                grid[0][2] = :X
                grid[0][3] = :X
                grid[0][4] = :X
                
                expect(board).to receive(:win_row?)
                board.win?(:X)
            end

            it "should use Board#win_column?" do
                grid = board.instance_variable_get(:@grid)
                grid[0][0] = :X
                grid[1][0] = :X
                grid[2][0] = :X
                grid[3][0] = :X
                grid[4][0] = :X

                
                expect(board).to receive(:win_column?)
                board.win?(:X)
            end

            it "should use Board#win_diagonal?" do
                grid = board.instance_variable_get(:@grid)
                grid[0][0] = :X
                grid[1][1] = :X
                grid[2][2] = :X
                grid[3][3] = :X
                grid[4][4] = :X
                
                expect(board).to receive(:win_diagonal?)
                board.win?(:X)
            end
        end

        describe "#empty_positions?" do
            context "when there is at least one empty position in @grid" do
                it "should return true" do
                    grid = board.instance_variable_get(:@grid)
                    grid.each { |r| r.replace([ :X, :X, :X, :X, :X ])}
                    grid[1][1] = "_"

                    expect(board.empty_positions?).to eq(true)
                end
            end

            context "when there is NOT at least one empty position in @grid" do
                it "should return false" do
                    grid = board.instance_variable_get(:@grid)
                    grid.each { |r| r.replace([ :X, :X, :X, :X, :X ])}

                    expect(board.empty_positions?).to eq(false)
                end
            end
        end
    end
end