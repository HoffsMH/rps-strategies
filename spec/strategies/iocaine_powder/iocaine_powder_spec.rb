require "rspec"
require "pry"

require_relative "../../../lib/game"
require_relative "../../../lib/strategies/iocaine_powder/iocaine_powder"


describe IocainePowder do
  it "has a list of prediction algorithms" do
    game = Game.new

    expect(IocainePowder.predictors).not_to eq(nil)
    expect(IocainePowder.predictors.keys).not_to eq([])
  end
  it "has a list of meta-strategies" do
    game = Game.new

    expect(IocainePowder.meta_strategies).not_to eq(nil)
    expect(IocainePowder.meta_strategies.keys).not_to eq([])
  end
  describe ".collect_scores" do
    context "when given a game with a history of 2 rounds" do
      it "returns the correct combination scoring" do
        # be careful when making test cases as atleast one of our prediction algorithms
        # predicts random after a tie
        game = Game.new
        game.play({computer: "s", opponent: "p", test_env: true})
        game.play({computer: "p", opponent: "r", test_env: true})

        result = IocainePowder.collect_scores(game.history)

        expect(result).to eq({"adaptive-last"=>{"P.0"=>1, "P.1"=>0, "P.2"=>-1}})
      end
    end
    context "when given a game with a history of more rounds" do
      it "returns the correct combination scoring" do
        game = Game.new
        20.times do
          game.play({computer: "s", opponent: "p", test_env: true})
        end

        result = IocainePowder.collect_scores(game.history)

        expect(result).to eq({"adaptive-last"=>{"P.0"=>0, "P.1"=>-19, "P.2"=>19}})
      end
    end
  end
end
