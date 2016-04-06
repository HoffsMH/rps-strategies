require "rspec"
require "pry"

require_relative "../../lib/game"
require_relative "../../lib/strategies/iocaine_powder"


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

  describe "scoring matrix" do
    context "when we suggest 'r'" do
      let!(:suggestion) { 'r'}
      context "and the opponent plays 'r'" do
        it "neither adds nor subtracts to the combination's score" do
          result = IocainePowder.scoring_matrix[suggestion]['r']
          expect(result).to eq(0)
        end
      end
      context "and the opponent plays 'p'" do
        it "subtracts from the combination's score" do
          result = IocainePowder.scoring_matrix[suggestion]['p']
          expect(result).to eq(-1)
        end
      end
      context "and the opponent plays 's'" do
        it "adds from the combination's score" do
          result = IocainePowder.scoring_matrix[suggestion]['s']
          expect(result).to eq(1)
        end
      end
    end
    context "when we suggest 'p'" do
      let!(:suggestion) { 'p'}
      context "and the opponent plays 'r'" do
        it "adds to the comination's score" do
          result = IocainePowder.scoring_matrix[suggestion]['r']
          expect(result).to eq(1)
        end
      end
      context "and the opponent plays 'p'" do
        it "neither adds or subtracts from the combination's score" do
          result = IocainePowder.scoring_matrix[suggestion]['p']
          expect(result).to eq(0)
        end
      end
      context "and the opponent plays 's'" do
        it "subtracts from the combination's score" do
          result = IocainePowder.scoring_matrix[suggestion]['s']
          expect(result).to eq(-1)
        end
      end
    end
    context "when we suggest 's'" do
      let!(:suggestion) { 's' }
      context "and the opponent plays 'r'" do
        it "subtracts from the the comination's score" do
          result = IocainePowder.scoring_matrix[suggestion]['r']
          expect(result).to eq(-1)
        end
      end
      context "and the opponent plays 'p'" do
        it "adds to the the combination's score" do
          result = IocainePowder.scoring_matrix[suggestion]['p']
          expect(result).to eq(1)
        end
      end
      context "and the opponent plays 's'" do
        it "neither adds to or subtracts from the combination's score" do
          result = IocainePowder.scoring_matrix[suggestion]['s']
          expect(result).to eq(0)
        end
      end
    end
  end
  describe ".initial_combination_scores" do
    it "produces a hash of initial scores for each combination" do
      expected_hash = {
        "adaptive-last" => {
          "P.0" => 0,
          "P.1" => 0,
          "P.2" => 0,
        }
      }
      expect(IocainePowder.initial_combination_scores).to eq(expected_hash)
    end
  end
end
