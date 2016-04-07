require_relative "../../predictions/adaptive_last_predictor"
require_relative "../../predictions/favorite_predictor"
require_relative "./scoring.rb"

module IocainePowder

  def self.predictors
    {
      "adaptive-last" => AdaptiveLastPredictor,
      "favorite" => FavoritePredictor
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

  def self.evaluate(game)
    return nil if !game || !game.history
    return "p" if game.history.empty? || game.history.count == 1

    scores           = collect_scores(game.history)
    top_combinations = Scoring.get_top_combinations(scores)
    combination      = top_combinations.sample
    meta_strategy    = combination[:meta_strategy]
    predictor        = combination[:predictor]
    return meta_strategies[meta_strategy][predictors[predictor].predict(game.history)]
  end

  def self.collect_scores(history)
    score = Scoring.get_initial_scores(predictors, meta_strategies)

    history.each_with_index do |round, round_index|
      sub_history = history[0..round_index]
      next_round  = history[round_index + 1]
      if next_round
        score = run_predictors(sub_history, next_round, score)
      end
    end
    score
  end

  def self.run_predictors(history, next_round, score)
    predictors.each do |predictor_name, predictor|
      prediction = predictor.predict(history)
      score = run_strategies(predictor_name, prediction, next_round, score)
    end
    score
  end

  def self.run_strategies(predictor_name, prediction, next_round, score)
    meta_strategies.each do |strategy_name, strategy|
      suggestion = strategy[prediction]
      # helpful debug output:
      # puts "#{Scoring.matrix[suggestion][next_round[:opponent]]} to " <<
      #      "#{predictor_name}-#{strategy_name} with my suggestion of " <<
      #      "#{suggestion} the next move the opponent makes is " <<
      #      " #{next_round[:opponent]}"
      score[predictor_name][strategy_name] += Scoring.matrix[suggestion][next_round[:opponent]]
    end
    score
  end

end
