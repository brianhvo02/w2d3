require "./lib/tic_tac_toe_v3/computer_player"

describe "ComputerPlayer" do
    let(:player) { ComputerPlayer.new(:X) }

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
                player.get_position([[0, 0]])
            end
      
            it "should return a random position from the array" do
                expect(player.get_position([[0, 0]])).to match_array([0, 0])
            end
        end
    end
end