# frozen_string_literal: true
require 'spec_helper'

module Game
  describe Config do
    subject { described_class.new(config)}
    let(:config) { { players: 3,
      cells_position: ['E','H','J','T'],
      dice_output: [4,5,2,1],
      initial_money: 50,
      hotel_worth: 20,
      hotel_rent: 5,
      jail_fine: 5,
      treasure_value: 20
      } }

    context '#initalize' do
      it 'creates a new object' do
        expect(subject).to be_a_kind_of(Config)
      end
    end

    context '#validate_config' do
      it 'invalidates config' do
        config.delete(:players)
        expect { subject.validate_config }.to raise_error StandardError, "Missing [:players] keys in game.yml"
      end
    end

    context '#update_points' do
      let(:player) { {
        player_id: 1,
        position: 1,
        money: 100,
        hotel_owned: [4],
        total_worth: 120
      } }
      let(:new_position) { { cell_type: 'E', index: 1 } }

      context 'when on Empty cell' do
        it 'does not change player money' do
          expect(subject.update_points(player, new_position)).to eq(player[:money])
        end
      end

      context 'when on Treasure cell' do
        let(:new_position) { { cell_type: 'T', index: 4 } }

        it 'update player money' do
          expected_output = player[:money] + config[:treasure_value]
          expect(subject.update_points(player, new_position)).to eq(expected_output)
        end
      end

      context 'when on Jail cell' do
        let(:new_position) { { cell_type: 'J', index: 3 } }

        it 'update player money' do
          expected_output = player[:money] - config[:jail_fine]
          expect(subject.update_points(player, new_position)).to eq(expected_output)
        end
      end

      context 'when on Hotel cell' do
        let(:new_position) { { cell_type: 'H', index: 2 } }

        context '#calculate_hotel_point' do

        end
      end
    end
  end
end
