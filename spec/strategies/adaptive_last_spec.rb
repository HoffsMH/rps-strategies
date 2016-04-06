require "rspec"
require "pry"

require_relative "../../lib/game"
require_relative "../../lib/strategies/adaptive_last"


describe AdaptiveLast do
  describe "evaluate" do
    context "when the last move was a draw" do
      it "returns random" do
        game = Game.new
        game.play({computer: "p", opponent: "p", test_env: true})
        game.play({computer: "p", opponent: "p", test_env: true})
        game.play({computer: "p", opponent: "s", test_env: true})
        game.play({computer: "p", opponent: "r", test_env: true})
        game.play({computer: "p", opponent: "s", test_env: true})
        game.play({computer: "p", opponent: "p", test_env: true})


        result = AdaptiveLast.evaluate(game)

        expect(["r","p","s"]).to include(result)
      end
    end
    context "when the last move was a loss for the opponent" do
      context "and the opponents last move was 'r'" do
        it "recommends  'r'" do
          game = Game.new
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})


          result = AdaptiveLast.evaluate(game)

          expect(result).to eq('r')
        end
      end
      context "and the opponents last move was 'p'" do
        it "recommends  'p'" do
          game = Game.new
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "s", opponent: "p", test_env: true})


          result = AdaptiveLast.evaluate(game)

          expect(result).to eq('p')
        end
      end
      context "and the opponents last move was 's'" do
        it "recommends  's'" do
          game = Game.new
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "r", opponent: "s", test_env: true})


          result = AdaptiveLast.evaluate(game)

          expect(result).to eq('s')
        end
      end
    end
    context "when the last move was a win for the opponent" do
      context "and the opponents last move was 'r'" do
        it "recommends  'p'" do
          game = Game.new
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "s", opponent: "r", test_env: true})


          result = AdaptiveLast.evaluate(game)

          expect(result).to eq('p')
        end
      end
      context "and the opponents last move was 'p'" do
        it "recommends  's'" do
          game = Game.new
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "r", opponent: "p", test_env: true})


          result = AdaptiveLast.evaluate(game)

          expect(result).to eq('s')
        end
      end
      context "and the opponents last move was 's'" do
        it "recommends  'r'" do
          game = Game.new
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "p", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "r", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})
          game.play({computer: "p", opponent: "s", test_env: true})


          result = AdaptiveLast.evaluate(game)

          expect(result).to eq('r')
        end
      end
    end
  end
end
