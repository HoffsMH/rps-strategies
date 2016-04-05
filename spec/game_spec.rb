require "rspec"
require "pry"
require_relative "../lib/game"

describe Game do
  context "rock" do
    it "beats scissors" do
      game = Game.new
      result = game.play({computer: "r", opponent: "s"})
      # I chose 's'. You win!
      # you won 1 times.
      # you lost 0 times.
      # we tied 0 times.
      {
        play: {computer: "r", opponent: "s"},
        score: {computer: 1, opponent: 0, draw: 0}
      }
      expect(result[:play]).to eq({computer: "r", opponent: "s"})
      expect(result[:score][:computer]).to eq(1)
      expect(result[:score][:opponent]).to eq(0)
      expect(result[:score][:draw]).to eq(0)
    end
  end
end
