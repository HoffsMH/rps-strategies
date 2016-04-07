require "rspec"
require "pry"

require_relative "../../../lib/game"
require_relative "../../../lib/strategies/iocaine_powder/iocaine_powder"
require_relative "../../../lib/strategies/iocaine_powder/scoring"

describe Scoring do
  describe ".get_initial_scores" do
    it "produces a hash of initial scores for each combination" do
      expected_hash = {
        "adaptive-last" => {
          "P.0" => 0,
          "P.1" => 0,
          "P.2" => 0,
        },
        "favorite" => {
          "P.0"=>0,
          "P.1"=>0,
          "P.2"=>0
        },
         "history-matcher" =>{
           "P.0"=>0,
           "P.1"=>0,
           "P.2"=>0
         }
      }
      result = Scoring.get_initial_scores(
        IocainePowder.predictors,
        IocainePowder.meta_strategies
       )
      expect(result).to eq(expected_hash)
    end
  end
  describe ".matrix" do
    context "when we suggest 'r'" do
      let!(:suggestion) { 'r'}
      context "and the opponent plays 'r'" do
        it "neither adds nor subtracts to the combination's score" do
          result = Scoring.matrix[suggestion]['r']
          expect(result).to eq(0)
        end
      end
      context "and the opponent plays 'p'" do
        it "subtracts from the combination's score" do
          result = Scoring.matrix[suggestion]['p']
          expect(result).to eq(-1)
        end
      end
      context "and the opponent plays 's'" do
        it "adds from the combination's score" do
          result = Scoring.matrix[suggestion]['s']
          expect(result).to eq(1)
        end
      end
    end
    context "when we suggest 'p'" do
      let!(:suggestion) { 'p'}
      context "and the opponent plays 'r'" do
        it "adds to the comination's score" do
          result = Scoring.matrix[suggestion]['r']
          expect(result).to eq(1)
        end
      end
      context "and the opponent plays 'p'" do
        it "neither adds or subtracts from the combination's score" do
          result = Scoring.matrix[suggestion]['p']
          expect(result).to eq(0)
        end
      end
      context "and the opponent plays 's'" do
        it "subtracts from the combination's score" do
          result = Scoring.matrix[suggestion]['s']
          expect(result).to eq(-1)
        end
      end
    end
    context "when we suggest 's'" do
      let!(:suggestion) { 's' }
      context "and the opponent plays 'r'" do
        it "subtracts from the the comination's score" do
          result = Scoring.matrix[suggestion]['r']
          expect(result).to eq(-1)
        end
      end
      context "and the opponent plays 'p'" do
        it "adds to the the combination's score" do
          result = Scoring.matrix[suggestion]['p']
          expect(result).to eq(1)
        end
      end
      context "and the opponent plays 's'" do
        it "neither adds to or subtracts from the combination's score" do
          result = Scoring.matrix[suggestion]['s']
          expect(result).to eq(0)
        end
      end
    end
  end
  describe ".get_top_combinations" do
    context "when there is no tie" do
      let!(:scores) do
        {
          "adaptive-last" => {
            "P.0" => 2,
            "P.1" => 5,
            "P.2" => 1,
          },
          "favorite" => {
            "P.0"=>0,
            "P.1"=>0,
            "P.2"=>0
          },
           "history-matcher" =>{
             "P.0"=>0,
             "P.1"=>0,
             "P.2"=>0
           }
        }
      end
      it "returns the top combination" do
        result = Scoring.get_top_combinations(scores)

        expect(result).to eq([{predictor: "adaptive-last", meta_strategy: "P.1"}])
      end
    end
    context "when there is a tie" do
      let!(:scores) do
        {
          "adaptive-last" => {
            "P.0" => 3,
            "P.1" => 3,
            "P.2" => 1,
          },
          "favorite" => {
            "P.0"=>0,
            "P.1"=>0,
            "P.2"=>0
          },
           "history-matcher" =>{
             "P.0"=>0,
             "P.1"=>0,
             "P.2"=>0
           }
        }
      end
      it "returns the top combination" do
        result = Scoring.get_top_combinations(scores)

        expect(result).to eq([{predictor: "adaptive-last", meta_strategy: "P.0"},
                              {predictor: "adaptive-last", meta_strategy: "P.1"}])
      end
    end
  end

end
