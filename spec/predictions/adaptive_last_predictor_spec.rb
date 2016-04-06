require "rspec"
require "pry"

require_relative "../../lib/game"
require_relative "../../lib/predictions/adaptive_last_predictor"


describe AdaptiveLastPredictor do
  context ".predict" do
    context "when not given a game" do
      it "returns nil" do
        result = AdaptiveLastPredictor.predict(nil)
        expect(result).to be_nil
      end
    end
    context "when given an empty history" do
      # human opponents tend to choose rock as their opening move
      # http://www.livescience.com/15574-win-rock-paper-scissors.html
      it "returns paper" do
        game = Game.new
        result = AdaptiveLastPredictor.predict(game.history)

        expect(result).to eq("p")
      end
    end
  end
end
