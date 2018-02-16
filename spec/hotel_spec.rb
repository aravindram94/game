# frozen_string_literal: true
require 'spec_helper'

module Game
  describe Hotel do
    subject { described_class.new(options)}
    let(:options) { {
      hotel_id: 1,
      rent: 10,
      worth: 50
     } }
     let(:player) { {
      player_id: 1,
      money: 100,
      hotel_owned: [],
      position: 0,
      total_woth: 100
      } }

    context '#initalize' do
      it 'creates a new object' do
        expect(subject).to be_a_kind_of(Hotel)
      end
    end

    context 'calculate_hotel_point' do
      context 'pre_owned?' do
        it 'true and calls pay_owner' do
          expect(subject).to receive(:pre_owned?).and_return(true)
          expect(subject).to receive(:pay_owner)
          subject.calculate_hotel_point(player)
        end

        it 'false and calls buy_hotel' do
          expect(subject).to receive(:pre_owned?).and_return(false)
          expect(subject).to receive(:buy_hotel)
          subject.calculate_hotel_point(player)
        end
      end
    end

    # context 'buy_hotel'  do
    #   it 'player has money' do
    #     expect(subject).to receive(:can_buy?).and_return(true)
    #     subject.buy_hotel(player)
    #   end

    #   it 'player does not have money' do
    #   end
    # end
  end
end
