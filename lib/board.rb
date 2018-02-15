# frozen_string_literal: true

require 'game/base_config'
require 'game/version'

module Game
  class Board
    attr_reader :cells_position, :hotel_worth, :hotel_rent, :jail_fine, :treasure_value

    def initialize(config = {})
      @cells_position = config[:cells_position]
      @hotel_rent = config[:hotel_rent]
      @hotel_worth = config[:hotel_worth]
      @jail_fine = config[:jail_fine]
      @treasure_value = config[:treasure_value]
    end

    def move_player(current_position, dice_output)
      new_position = current_position + dice_output
      new_position = { cell_type: @cells_position[new_position],
        index: new_position
      }
    end
  end
end
