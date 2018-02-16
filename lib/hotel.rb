# frozen_string_literal: true

require 'game/base_config'
require 'game/version'

module Game
  # Hotel class has attributes / methods of a hotel
  class Hotel
    attr_accessor :hotel_id, :hotel_rent, :hotel_worth, :owner

    def initialize(options = {})
      @hotel_id = options[:hotel_id]
      @hotel_rent = options[:rent]
      @hotel_worth = options[:worth]
      @owner = []
    end

    def calculate_hotel_point(player)
      if pre_owned?
        pay_owner(player)
      else
        buy_hotel(player)
      end
    end

    def pre_owned?
      owner.empty? ? false : true
    end

    def can_buy?(player)
      player.money > hotel_worth
    end

    def pay_owner(player)
      return if owner.empty?
      player.money -= hotel_rent
      owner[0].money += hotel_rent
    end

    def buy_hotel(player)
      return unless can_buy?(player)
      player.money -= hotel_worth
      player.hotel_owned.push(self)
      owner.push(player)
    end
  end
end
