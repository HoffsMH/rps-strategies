require_relative "../../predictions/adaptive_last_predictor"
require_relative "./scoring.rb"

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

  def self.evaluate(game)
    return nil if !game || !game.history
    return "p" if game.history.empty?

  end
end
