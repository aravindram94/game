# frozen_string_literal: true

module Game
  class Config
    def self.to_h
      config.dup
    end

    def self.config
      YAML.safe_load(File.read('config/game.yml'), [], [], true).deep_symbolize_keys
    rescue Errno::ENOENT
      raise ConfigError, 'Error: game.yml not found.'
    end
  end

  # Public: An error indicating an issue related to an interaction with CommonConfig.
  class ConfigError < StandardError; end
end
