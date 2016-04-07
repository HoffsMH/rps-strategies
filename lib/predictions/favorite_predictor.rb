module FavoritePredictor

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

  def self.predict(history)
    return nil if !history
    return "p" if history.empty?

    return get_max(get_counts(history))
  end
end
