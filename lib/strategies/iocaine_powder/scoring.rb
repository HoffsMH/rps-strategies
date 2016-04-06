module Scoring

  def self.get_initial_scores(predictors, strategies)
    scores = {}
    predictors.keys.each do |predictor_key|
      scores[predictor_key] = get_initial_strategy_scores(strategies)
    end
    scores
  end

  def self.get_initial_strategy_scores(strategies)
    scores = {}
    strategies.keys.each do |strategy_key|
      scores[strategy_key] = 0
    end
    scores
  end

  def self.matrix
    #first key is computers suggestion
    # second key is opponent's actual next move
    {
      "r" => {"r" => 0, "p" => -1, "s" => 1},
      "p" => {"r" => 1, "p" => 0, "s" => -1},
      "s" => {"r" => -1, "p" => 1, "s" => 0},
    }
  end

  def self.get_top_combinations(scores)
    top_scores = {
      current_top: 0,
      scores: [],
    }
    scores.keys.each do |predictor_key|
      scores[predictor_key].keys.each do |strategy_key|
        current = {
          score: scores[predictor_key][strategy_key],
          predictor_key: predictor_key,
          strategy_key: strategy_key
        }

        top_scores = update_top_scores(top_scores, current)
      end
    end
    top_scores[:scores]
  end

  def self.update_top_scores(top_scores, current)
    if current[:score] == top_scores[:current_top]
      top_scores[:scores].push({
        predictor: current[:predictor_key],
        meta_strategy: current[:strategy_key]
        })
    elsif current[:score] > top_scores[:current_top]
      top_scores[:current_top] = current[:score]
      top_scores[:scores] = [{
        predictor: current[:predictor_key],
        meta_strategy: current[:strategy_key]
        }]
    end
    top_scores
  end

end
