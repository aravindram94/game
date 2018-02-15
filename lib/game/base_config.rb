# frozen_string_literal: true

module Game
  # Class to read user config for game
  class Config
    def self.to_h
      config.dup
    end

    def self.config(file_name)
      YAML.safe_load(File.read(file_name), [], [], true).deep_symbolize_keys
    rescue Errno::ENOENT
      raise ConfigError, 'Error:  config file not found.'
    end
  end

  # Public: An error indicating an issue CommonConfig.
  class ConfigError < StandardError; end
end
