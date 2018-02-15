# frozen_string_literal: true

require 'game/base_config'
require 'game/version'

module Game
  # Board class has attributes / methods for a board
  class Board
    attr_reader :cells_position,
                :jail_fine,
                :treasure_value

    def initialize(config = {})
      @cells_position = config[:cells_position]
      @jail_fine = config[:jail_fine]
      @treasure_value = config[:treasure_value]
    end

    def move_player(current_position, dice_output)
      new_position = (current_position + dice_output) % @cells_position.length
      {
        cell_type: @cells_position[new_position - 1],
        index: new_position
      }
    rescue ZeroDivisionError => e
      puts "Error: #{e.message}"
    end
  end
end
