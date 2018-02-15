# frozen_string_literal: true
require 'spec_helper'

module Game
  describe Board do
    subject { described_class.new(input_hash)}
    let(:cells_position) { ['E', 'H', 'J', 'T'] }
    let(:input_hash) { { cells_position: cells_position,
        jail_fine: 10,
        treasure_value: 100
      } }

    context '#initalize' do
      it 'creates a new object' do
        expect(subject).to be_a_kind_of(Board)
      end
    end

    context '#move_player' do
      let(:current_position) { 3 }
      let(:dice_output) { 2 }

      context 'when inputs are correct' do
        let(:expected_output) { {
          cell_type: 'E',
          index: 1
        }}

        it 'returns the new position hash' do
          expect(subject.move_player(current_position, dice_output)).to eq(expected_output)
        end
      end
    end
  end
end
