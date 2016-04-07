require "rspec"
require "pry"

require_relative "../../lib/game"
require_relative "../../lib/predictions/history_matcher_predictor"


describe HistoryMatcherPredictor do
  describe ".predict" do
    context "when given an empty history" do
      it "predicts r" do
        game = Game.new
        result = HistoryMatcherPredictor.predict(game.history)

        expect(result).to eq('r')
      end
    end
    context "when given a history that only has one round" do
      it "predicts r" do
        game = Game.new
        game.play({computer: "p", opponent: "s", test_env: true})
        result = HistoryMatcherPredictor.predict(game.history)

        expect(result).to eq('r')
      end
    end
    context "when given a simple history of s" do
      it "predicts s" do
        game = Game.new
        game.play({computer: "p", opponent: "s", test_env: true})
        game.play({computer: "p", opponent: "s", test_env: true})
        game.play({computer: "p", opponent: "s", test_env: true})


        result = HistoryMatcherPredictor.predict(game.history)

        expect(result).to eq('s')
      end
    end
    context "when given a simple history of p" do
      it "predicts p" do
        game = Game.new
        game.play({computer: "p", opponent: "p", test_env: true})
        game.play({computer: "p", opponent: "p", test_env: true})
        game.play({computer: "p", opponent: "p", test_env: true})


        result = HistoryMatcherPredictor.predict(game.history)

        expect(result).to eq('p')
      end
    end
    context "when given a simple history of r" do
      it "predicts r" do
        game = Game.new
        game.play({computer: "p", opponent: "r", test_env: true})
        game.play({computer: "p", opponent: "r", test_env: true})
        game.play({computer: "p", opponent: "r", test_env: true})


        result = HistoryMatcherPredictor.predict(game.history)

        expect(result).to eq('r')
      end
    end
    context "complex history" do
      it "predicts s" do
        game = Game.new
        game.play({computer: "s", opponent: "p", test_env: true}) # ...
        game.play({computer: "p", opponent: "r", test_env: true}) # matching pattern of 2 starts here

        game.play({computer: "r", opponent: "p", test_env: true})
        game.play({computer: "s", opponent: "s", test_env: true})

        game.play({computer: "r", opponent: "r", test_env: true}) # ...
        game.play({computer: "s", opponent: "p", test_env: true}) # ...
        game.play({computer: "p", opponent: "r", test_env: true}) # matching pattern of 3 starts here
        game.play({computer: "r", opponent: "s", test_env: true}) # <= should predict that opponent's 's'


        game.play({computer: "r", opponent: "p", test_env: true})
        game.play({computer: "s", opponent: "s", test_env: true})
        game.play({computer: "p", opponent: "r", test_env: true}) #matching pattern of 1 starts here

        game.play({computer: "r", opponent: "r", test_env: true})
        game.play({computer: "s", opponent: "p", test_env: true})
        game.play({computer: "p", opponent: "r", test_env: true})


        result = HistoryMatcherPredictor.predict(game.history)

        expect(result).to eq('s')
      end
    end
  end
end
