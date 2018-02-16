# frozen_string_literal: true
require 'spec_helper'

module Game
  describe Player do
    subject { described_class.new(options)}
    let(:options) { { players: 3, initial_money: 100 } }

    context '#initalize' do
      it 'creates a new object' do
        expect(subject).to be_a_kind_of(Player)
      end
    end

    context '#total_worth?' do
      it 'returns the player hash' do
        expect(subject).to receive(:total_worth?).and_return(100)
        subject.total_worth?
      end
    end
  end
end
