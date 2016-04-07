module HistoryMatcherPredictor

  def self.predict(history)
    last_round = history[-1]

    current_match_count = 0
    highest_match_count = 0
    starting_match_index = nil
    still_matching = false
    suggestion = 'r'

    history.reverse.each_with_index do |current_round, current_round_index|
      next if current_round_index == 0

      if !still_matching && current_round == last_round
        starting_match_index = current_round_index
        still_matching = true
        current_match_count = 1
      elsif still_matching && current_round == history[-1 - current_match_count]
        current_match_count += 1
      elsif still_matching && current_round != history[-1 - current_match_count]
        starting_match_index = nil
        still_matching = false
        current_match_count = 0
      end

      if still_matching && (current_match_count > highest_match_count)
        highest_match_count = current_match_count
        suggestion = history.reverse[starting_match_index - 1][:opponent]
      end
    end
    suggestion
  end

end
