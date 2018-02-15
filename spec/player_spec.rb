# frozen_string_literal: true
require 'spec_helper'

module Game
  describe Player do
    let(:player) { double :player }
    let(:players) { 1 }
    let(:initial_money) { 1000 }

    context '#initalize' do
      it 'creates a new object' do
        expect(Player).to receive(:new).with(player, initial_money).and_return(player)
        Player.new(player, initial_money)
      end
    end

    context '#show' do
      let(:player_hash) { 'player_hash' }

      it 'returns the player hash' do
        expect_any_instance_of(Player).to receive(:show).and_return(player_hash)

        p = Player.new
        p.show
      end
    end
  end
end
