# frozen_string_literal: true

require 'game/base_config'
require 'game/version'

module Game
  # Player class has attributes / methods of a player
  class Player
    attr_accessor :player_id, :position, :money, :hotel_owned, :total_worth

    def initialize(options = {})
      # Default:
      # Position: 0
      @player_id = options[:players]
      @position = 0
      @hotel_owned = []
      @money = options[:initial_money]
      @total_worth = @money
    end

    def update_total_worth
      self.total_worth = money
      hotel_owned.each do |hotel|
        self.total_worth += hotel.hotel_worth
      end
    end
  end
end
