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

    # Game starts here
    def start
      moves = 1
      while moves <= MAX_MOVES
        @players.each do |player|
          dice_output = @dice.roll
          new_position = @board.move_player(player.position, dice_output)
          player.position = new_position[:index]
          update_points(player, new_position)
        end
        moves += 1
      end
      calculate_total_worth
    end

    # Updates money for each player based on dice roll and board cell types
    def update_points(player, new_position)
      case new_position[:cell_type]
      when 'J'
        point = -@board.jail_fine
      when 'T'
        point = @board.treasure_value
      when 'H'
        hotel_info = @hotels.find { |h| h.hotel_id == new_position[:index] }
        hotel_info.calculate_hotel_point(player)
      when 'E'
        point = 0
      end
      player.money += point unless point.nil?
    end

    private

    # Update total_worth of each player => money remaining + hotels worth
    def calculate_total_worth
      @players.each(&:update_total_worth)
      @players.sort_by(&:total_worth).reverse!
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
      1.upto(config[:players]) do |i|
        options = {
          players: i,
          initial_money: @config[:initial_money]
        }
        player = create(Game::Player, options)
        @players.push(player)
      end
    end

    def create_board
      options = {
        cells_position: @config[:cells_position],
        jail_fine: @config[:jail_fine],
        treasure_value: @config[:treasure_value]
      }
      @board ||= create(Game::Board, options)
    end

    def create_dice
      options = {
        dice_output: @config[:dice_output]
      }
      @dice ||= create(Game::Dice, options)
    end

    def create_hotels
      @config[:cells_position].each_with_index do |cell_pos, index|
        if cell_pos == 'H'
          options = {
            hotel_id: index + 1,
            rent: @config[:hotel_rent],
            worth: @config[:hotel_worth]
          }
          hotel = create(Game::Hotel, options)
        end
        @hotels.push(hotel) unless hotel.nil?
      end
    end

    # Reusable create method
    def create(class_name, params = {})
      class_name.new(params)
    end
  end
end
