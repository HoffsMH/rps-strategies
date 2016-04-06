require "rspec"
require "pry"

require_relative "../../../lib/game"
require_relative "../../../lib/strategies/iocaine_powder/iocaine_powder"


describe IocainePowder do
  it "has a list of prediction algorithms" do
    game = Game.new

    expect(IocainePowder.predictors).not_to eq(nil)
    expect(IocainePowder.predictors.keys).not_to eq([])
  end
  it "has a list of meta-strategies" do
    game = Game.new

    expect(IocainePowder.meta_strategies).not_to eq(nil)
    expect(IocainePowder.meta_strategies.keys).not_to eq([])
  end

end
