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

    if game.history.last[:winner] ==  "draw"
      return suggestions.keys.sample
    end
  end

  def self.name
    'adaptive-last'
  end
end
