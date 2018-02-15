# frozen_string_literal: true

require 'game/base_config'
require 'game/version'
require 'board'
require 'dice'
require 'player'
require 'hotel'

module Game
  # Game class has attributes / methods inorder to play a game
  class Config
    attr_reader :config, :players, :dice, :board, :hotels

    MAX_MOVES = 10

    def initialize(config = {})
      @config = config
      @players = []
      @hotels = []
      validate_config
      create_players
      create_board
      create_dice
      create_hotels
    end

    def start
      moves = 1
      while moves <= MAX_MOVES
        @players.each do |player|
          dice_output = @dice.roll
          new_position = @board.move_player(player[:position], dice_output)
          player[:position] = new_position[:index]
          update_points(player, new_position)
        end
        moves += 1
      end
      calculate_total_worth
    end

    def update_points(player, new_position)
      case new_position[:cell_type]
      when 'J'
        point = -@board.jail_fine
      when 'T'
        point = @board.treasure_value
      when 'H'
        calculate_hotel_point(player, new_position[:index])
      when 'E'
        point = 0
      end
      player[:money] += point unless point.nil?
    end

    private

    def calculate_total_worth
      @players.each do |player|
        player[:total_worth] = player[:money]
        player[:hotel_owned].each do |id|
          hotel_info = @hotels.find { |hotel| hotel[:hotel_id] == id }
          player[:total_worth] += hotel_info[:hotel_worth]
        end
      end
      @players.sort_by { |player| player[:total_worth] }
    end

    def calculate_hotel_point(player, hotel_id)
      hotel_info = find_hotel(hotel_id)
      if pre_owned?(hotel_info)
        pay_owner(hotel_info, player)
      else
        buy_hotel(hotel_info, player)
      end
    end

    def pay_owner(hotel_info, player)
      return if hotel_info[:owner].nil?
      owner_info = @players.find { |per| per[:player_id] == hotel_info[:owner] }
      player[:money] -= hotel_info[:hotel_rent]
      owner_info[:money] += hotel_info[:hotel_rent]
    end

    def find_hotel(hotel_id)
      @hotels.find { |hotel| hotel[:hotel_id] == hotel_id }
    end

    def buy_hotel(hotel_info, player)
      return unless can_buy?(hotel_info, player)
      player[:money] -= hotel_info[:hotel_worth]
      player[:hotel_owned].push(hotel_info[:hotel_id])
      hotel_info[:owner] = player[:player_id]
    end

    def rent_price
      @hotel_rent
    end

    def can_buy?(hotel_info, player)
      player[:money] > hotel_info[:hotel_worth]
    end

    def pre_owned?(hotel_info)
      hotel_info[:owner].nil? ? false : true
    end

    # Validate required keys for playing game are present
    def validate_config
      valid_keys = %i[players
                      cells_position
                      dice_output
                      initial_money
                      hotel_worth
                      hotel_rent
                      jail_fine
                      treasure_value]
      config_keys = @config.keys
      missing_keys = valid_keys - config_keys
      raise StandardError, "Missing #{missing_keys} keys in game.yml" unless missing_keys.empty?
    end

    def create_players
      1.upto(config[:players]) do |player|
        player = Game::Player.new(player, config[:initial_money])
        @players.push(player.show)
      end
    end

    def create_board
      @board ||= Game::Board.new(@config)
    end

    def create_dice
      @dice ||= Game::Dice.new(@config[:dice_output])
    end

    def create_hotels
      @config[:cells_position].each_with_index do |cell_pos, index|
        if cell_pos == 'H'
          hotel = Game::Hotel.new(index + 1,
                                  @config[:hotel_rent],
                                  @config[:hotel_worth])
        end
        @hotels.push(hotel.show) unless hotel.nil?
      end
    end
  end
end
