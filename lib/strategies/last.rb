module Last
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

    last_move = game.history.last[:opponent]
    return suggestions[last_move]
  end

  def self.name
    'last'
  end
end
