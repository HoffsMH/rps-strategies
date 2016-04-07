require "rspec"
require "pry"

require_relative "../../lib/game"
require_relative "../../lib/predictions/favorite_predictor"


describe FavoritePredictor do
  describe ".predict" do
    context "when not given a history" do
      it "returns nil" do
        result = FavoritePredictor.predict(nil)
        expect(result).to be_nil
      end
    end
    context "when given an empty history" do
      # human opponents tend to choose rock as their opening move
      # http://www.livescience.com/15574-win-rock-paper-scissors.html
      it "returns paper" do
        game = Game.new
        result = FavoritePredictor.predict(game.history)

        expect(result).to eq("p")
      end
    end
    context "when given a history" do
      context "and opponent history favors 'r'" do
        it "returns 'r'" do
          game = Game.new
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})

          result = FavoritePredictor.predict(game.history)

          expect(result).to eq('r')
        end
      end
      context "and opponent history favors 'p'" do
        it "returns 'p'" do
          game = Game.new
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})

          result = FavoritePredictor.predict(game.history)

          expect(result).to eq('p')
        end
      end
      context "and opponent history favors 's'" do
        it "returns 's'" do
          game = Game.new
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})

          result = FavoritePredictor.predict(game.history)

          expect(result).to eq('s')
        end
      end
      context "and opponent history favor's 2 moves equally" do
        it "returns the counter either of the 2 moves randomly" do
          game = Game.new
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})

          result = FavoritePredictor.predict(game.history)


          expect(["r","s"]).to include(result)
        end
      end
      context "and opponent history doesn't favor an particular move" do
        it "returns the counter to a random move" do
          game = Game.new
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})


          result = FavoritePredictor.predict(game.history)

          expect(["r","p","s"]).to include(result)
        end
      end
    end
  end
end
