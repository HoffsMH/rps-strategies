class Game
  attr_accessor :history, :score

  def initialize
    @score = {
      computer: 0,
      opponent: 0,
      draw:     0
    }
    @history = []
  end

  def rules
    {
      "r" => { "s" => true, "p" => false },
      "p" => { "r" => true, "s" => false },
      "s" => { "p" => true, "r" => false }
    }
  end

  def valid_turn(turn)
    # both the computer and the opponent have chosen a value and
    # that value is a valid rps move

    turn[:computer] && rules[turn[:computer]] &&
    turn[:opponent] && rules[turn[:opponent]]
  end

  def console_output(turn, winner)
    # only show messages to stdout when we are not in test mode
    # to make our test output easier to read
    turn[:test_env] ? return : nil

    print "I chose '#{turn[:computer]}'. "
    if winner == "computer"
      print "I Win!\n"
    elsif winner == "opponent"
      print "You Win!\n"
    else
      print "It's a Tie!\n"
    end
    puts "You won #{@score[:opponent]} times."
    puts "I won #{@score[:computer]} times."
    puts "We tied #{@score[:draw]} times."
    puts
  end

  def play(turn)
    # if the turn is invalid we return nil
    valid_turn(turn) ? nil : return
    winner = make_ruling(turn)
    console_output(turn, winner)

    {
      play: record_turn(turn, winner),
      score: @score
    }
  end

  # the only exposed stateful method should be play
  private

  def make_ruling(turn)
    computers_move = turn[:computer]
    opponents_move = turn[:opponent]

    if computers_move == opponents_move
      @score[:draw] += 1
      return "draw"
    elsif rules[computers_move][opponents_move]
      @score[:computer] += 1
      return "computer"
    elsif rules[opponents_move][computers_move]
      @score[:opponent] += 1
      return "opponent"
    end
  end

  def record_turn(turn, winner)
    turn_output = {
      computer: turn[:computer],
      opponent: turn[:opponent],
      winner: winner
    }
    @history.push(turn_output)
    turn_output
  end
end
