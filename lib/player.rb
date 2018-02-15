# frozen_string_literal: true

require 'game/base_config'
require 'game/version'

module Game
  class Player
    attr_reader :player_id, :position, :money, :hotel_owned, :total_worth

    def initialize(player = 0, initial_money = 0)
      # Default:
      # hotel owned : -1, meaning player does not own a hotel yet
      @player_id = player
      @position = 0
      @money = initial_money
      @hotel_owned = [ ]
      @total_worth = @money
    end

    def show
      player_hash = {
        player_id: @player_id,
        position: @position,
        money: @money,
        hotel_owned: @hotel_owned,
        total_worth: @total_worth
      }
    end
  end
end
