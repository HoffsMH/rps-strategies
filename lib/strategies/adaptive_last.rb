module AdaptiveLast
  def self.suggestions
    {
      "r" => "p",
      "p" => "s",
      "s" => "r"
    }
  end

  def self.evaluate(game)
    return nil if !game || !game.history
    return "p" if game.history.empty?

    last_score = game.history.last[:winner]

    case last_score
    when "draw"
      return suggestions.keys.sample
    when "opponent"
      return suggestions[game.history.last[:opponent]]
    when "computer"
      return game.history.last[:opponent]
    end
  end

  def self.name
    'adaptive-last'
  end
end
