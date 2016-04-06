module Favorite

  def self.suggestions
    {
      "r" => "p",
      "p" => "s",
      "s" => "r"
    }
  end

  def self.get_counts(history)
    grouped_history = history.group_by { |turn| turn[:opponent] }

    grouped_history.map do |move|
      [move.first, move.last.count]
    end.to_h
  end

  def self.get_max(counts)
    max = counts.values.max
    top_moves = counts.reduce([]) do |top_moves, move|
      move.last == max ? top_moves.push(move.first) : top_moves
    end
    top_moves.sample
  end

  def self.evaluate(game)
    return nil if !game || !game.history
    return "p" if game.history.empty?

    return suggestions[get_max(get_counts(game.history))]
  end

  def self.name
    'favorite'
  end
end
