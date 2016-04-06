require_relative "../predictions/adaptive_last_predictor"

module IocainePowder
  def self.predictors
    {
      "adaptive-last" => AdaptiveLast
    }
  end

  def self.meta_strategies
    {
      "P.0" => naive_application,
      "P.1" => second_guess,
      "P.2" => third_guess
    }
  end

  def self.naive_application
    {
      "r" => "p",
      "p" => "s",
      "s" => "r"
    }
  end

  def self.second_guess
    {
      "r" => "r",
      "p" => "p",
      "s" => "s"
    }
  end

  def self.third_guess
    {
      "r" => "s",
      "p" => "r",
      "s" => "p"
    }
  end

  def self.scoring_matrix
    #first key is computers suggestion
    # second key is opponent's actual next move
    {
      "r" => {"r" => 0, "p" => -1, "s" => 1},
      "p" => {"r" => 1, "p" => 0, "s" => -1},
      "s" => {"r" => -1, "p" => 1, "s" => 0},
    }
  end

  def self.initial_combination_scores
    scores = {}
    predictors.keys.each do |predictor_key|
      scores[predictor_key] = initial_strategy_scores
    end
    scores
  end

  def self.initial_strategy_scores
    scores = {}
    meta_strategies.keys.each do |strategy_key|
      scores[strategy_key] = 0
    end
    scores
  end

  def self.evaluate(game)
    return nil if !game || !game.history
    return "p" if game.history.empty?

  end
end
