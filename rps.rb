require_relative "lib/game"
require_relative "lib/strategies/list"

game = Game.new
strategy_choice = ARGV[0]

if Strategies[strategy_choice]
  strategy = Strategies[strategy_choice].new
else
  strategy = Strategies['default'].new
end

puts "You are playing against strategy '#{strategy.name}'."

choice = ""
while choice != "q" do
  computer_choice = strategy.evaluate(game)
  puts "Type 'r', 'p', 's' or 'q' to quit."
  print ">"

  #  STDIN to avoid .gets trying to use our command line option
  choice = STDIN.gets.chomp
  game.play({computer: computer_choice, opponent: choice})
end
