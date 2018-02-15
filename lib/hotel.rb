# frozen_string_literal: true

require 'game/base_config'
require 'game/version'

module Game
  class Hotel
    attr_reader :hotel_id, :hotel_rent, :hotel_worth, :owner

    def initialize(id, rent, worth)
      @hotel_id = id
      @hotel_rent = rent
      @hotel_worth = worth
    end

    def show
      hotel_hash = {
        hotel_id: @hotel_id,
        hotel_rent: @hotel_rent,
        owner: @owner,
        hotel_worth: @hotel_worth
      }
    end
  end
end
