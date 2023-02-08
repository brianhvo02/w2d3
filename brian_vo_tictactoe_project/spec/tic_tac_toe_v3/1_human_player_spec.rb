require "./lib/tic_tac_toe_v3/human_player"

describe "HumanPlayer" do
    let(:player) { HumanPlayer.new(:X) }

    describe "Checkpoint - Test often, we're only human after all" do
        describe "#initialize" do
            it "should set @mark to be a single character" do
                expect(player.instance_variable_get(:@mark)).to eq(:X)
            end
        end

        describe "#mark" do
            it "should get (return) @mark" do
              expect(player.mark).to eq(player.instance_variable_get(:@mark))
            end
        end

        describe "#get_position" do
            it "should accept an array of legal positions" do
                input = double("1 2\n", :chomp=>"1 2")
                allow(player).to receive(:gets).and_return(input)
                player.get_position([[1, 2]])
            end

            it "should print 'enter a position as two numbers separated with a space like `1 2`'" do
                input = double("1 2\n", :chomp=>"1 2")
                allow(player).to receive(:gets).and_return(input)
        
                expect { player.get_position([[1, 2]]) }.to output(/X\nenter a position/).to_stdout
            end
      
            it "should call gets.chomp to get input from the user" do
                input = double("1 2\n", :chomp=>"1 2")
                allow(player).to receive(:gets).and_return(input)
        
                expect(input).to receive(:chomp)
                expect(player).to receive(:gets)
                player.get_position([[1, 2]])
            end
      
            it "should return an array containing the player's two input numbers as integers" do
                input = double("1 2\n", :chomp=>"1 2")
                allow(player).to receive(:gets).and_return(input)
                expect(player.get_position([[1, 2]])).to eq([1, 2])
            end
        end
    end
end