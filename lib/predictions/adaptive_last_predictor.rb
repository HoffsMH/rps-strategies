module AdaptiveLastPredictor
  def self.suggestions
    {
      "r" => "p",
      "p" => "s",
      "s" => "r"
    }
  end

  def self.predict(history)
    return nil if !history
    return "r" if history.empty?

    last_score = history.last[:winner]

    case last_score
    when "draw"
      return suggestions.keys.sample
    when "opponent"
      return history.last[:opponent]
    when "computer"
      return suggestions[history.last[:computer]]
    end
  end
end
