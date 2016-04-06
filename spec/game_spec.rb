require "rspec"
require "pry"
require_relative "../lib/game"

describe Game do
  describe "#play" do
    context "rock" do
      it "beats scissors" do
        game = Game.new

        result = game.play({computer: "r", opponent: "s", test_env: true})

        expect(result[:play]).to eq({computer: "r", opponent: "s", winner: "computer"})
        expect(result[:score][:computer]).to eq(1)
        expect(result[:score][:opponent]).to eq(0)
        expect(result[:score][:draw]).to eq(0)
      end
      it "loses to paper" do
        game = Game.new

        result = game.play({computer: "r", opponent: "p", test_env: true})

        expect(result[:play]).to eq({computer: "r", opponent: "p", winner: "opponent"})
        expect(result[:score][:computer]).to eq(0)
        expect(result[:score][:opponent]).to eq(1)
        expect(result[:score][:draw]).to eq(0)
      end
      it "draws with rock" do
        game = Game.new

        result = game.play({computer: "r", opponent: "r", test_env: true})

        expect(result[:play]).to eq({computer: "r", opponent: "r", winner: "draw"})
        expect(result[:score][:computer]).to eq(0)
        expect(result[:score][:opponent]).to eq(0)
        expect(result[:score][:draw]).to eq(1)
      end
    end

    context "paper" do
      it "beats rock" do
        game = Game.new

        result = game.play({computer: "p", opponent: "r", test_env: true})

        expect(result[:play]).to eq({computer: "p", opponent: "r", winner: "computer"})
        expect(result[:score][:computer]).to eq(1)
        expect(result[:score][:opponent]).to eq(0)
        expect(result[:score][:draw]).to eq(0)
      end
      it "loses to scissors" do
        game = Game.new

        result = game.play({computer: "p", opponent: "s", test_env: true})

        expect(result[:play]).to eq({computer: "p", opponent: "s", winner: "opponent"})
        expect(result[:score][:computer]).to eq(0)
        expect(result[:score][:opponent]).to eq(1)
        expect(result[:score][:draw]).to eq(0)
      end
      it "draws with paper" do
        game = Game.new

        result = game.play({computer: "p", opponent: "p", test_env: true})

        expect(result[:play]).to eq({computer: "p", opponent: "p", winner: "draw"})
        expect(result[:score][:computer]).to eq(0)
        expect(result[:score][:opponent]).to eq(0)
        expect(result[:score][:draw]).to eq(1)
      end
    end

    context "scissors" do
      it "beats paper" do
        game = Game.new

        result = game.play({computer: "s", opponent: "p", test_env: true})

        expect(result[:play]).to eq({computer: "s", opponent: "p", winner: "computer"})
        expect(result[:score][:computer]).to eq(1)
        expect(result[:score][:opponent]).to eq(0)
        expect(result[:score][:draw]).to eq(0)
      end
      it "loses to rock" do
        game = Game.new

        result = game.play({computer: "s", opponent: "r", test_env: true})

        expect(result[:play]).to eq({computer: "s", opponent: "r", winner: "opponent"})
        expect(result[:score][:computer]).to eq(0)
        expect(result[:score][:opponent]).to eq(1)
        expect(result[:score][:draw]).to eq(0)
      end
      it "draws with scissors" do
        game = Game.new

        result = game.play({computer: "s", opponent: "s", test_env: true})

        expect(result[:play]).to eq({computer: "s", opponent: "s", winner: "draw"})
        expect(result[:score][:computer]).to eq(0)
        expect(result[:score][:opponent]).to eq(0)
        expect(result[:score][:draw]).to eq(1)
      end
    end

    context "something other than 'r', 'p', or 's' is played" do
      it "returns nil" do
        game = Game.new

        result = game.play({computer: "r", opponent: "q", test_env: true})

        expect(result).to be_nil
      end
      it "doesn't record anything to history" do
        game = Game.new

        result = game.play({computer: "r", opponent: "q", test_env: true})

        expect(game.history.count).to eq(0)
      end
    end
  end
end
