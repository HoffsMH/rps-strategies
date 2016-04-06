require "rspec"
require "pry"

require_relative "../../lib/game"
require_relative "../../lib/strategies/last"


describe Last do
  describe ".evaluate" do
    context "when given a game with no history" do
      # human opponents tend to choose rock as their opening move
      # http://www.livescience.com/15574-win-rock-paper-scissors.html
      it "returns paper" do
        game = Game.new
        result = Last.evaluate(game)

        expect(result).to eq("p")
      end
    end
    context "when given a game with history" do
      context "and the opponents last move was 'r'" do
        it "returns p" do
          game = Game.new
          game.play({computer: "r", opponent: "r", test_env: true})

          result = Last.evaluate(game)

          expect(result).to eq('p')
        end
      end
      context "and the opponents last move was 'p'" do
        it "returns s" do
          game = Game.new
          game.play({computer: "p", opponent: "p", test_env: true})

          result = Last.evaluate(game)

          expect(result).to eq('s')
        end
      end
      context "and the opponents last move was 's'" do
        it "returns r" do
          game = Game.new
          game.play({computer: "s", opponent: "s", test_env: true})

          result = Last.evaluate(game)

          expect(result).to eq('r')
        end
      end
    end
  end
end
