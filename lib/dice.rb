# frozen_string_literal: true

require 'game/base_config'
require 'game/version'

module Game
  class Dice
    attr_reader :dice_output, :counter

    def initialize(dice_output = [])
      @dice_output = dice_output
      @counter = -1
    end

    def roll
      @counter = (@counter + 1) % @dice_output.length
      @dice_output[@counter]
    end
  end
end
