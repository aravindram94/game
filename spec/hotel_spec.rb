# frozen_string_literal: true
require 'spec_helper'

module Game
  describe Hotel do
    let(:hotel_options) { {
      hotel_id: 1,
      rent: 10,
      worth: 50
     } }
     subject { described_class.new(hotel_options)}
     let(:player_options) {{ players: 1, initial_money: 100}}
     let(:player) { Game::Player.new(player_options) }

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

    context 'buy_hotel'  do
      it 'player can buy' do
        subject.buy_hotel(player)
        expect(player.money).to eq(50)
        expect(player.hotel_owned).not_to be_empty
        expect(subject.owner).not_to be_empty
      end

      it 'player cannot buy' do
        player.money = 50
        subject.buy_hotel(player)
        expect(player.money).to eq(50)
        expect(player.hotel_owned).to be_empty
        expect(subject.owner).to be_empty
      end
    end

    context 'pay owner' do

      before do
        subject.buy_hotel(owner)
        player_options[:players] = 2
      end

      let(:owner) { player }
      let(:player_1) { Game::Player.new(player_options) }

      it 'player and owner money updated' do
        expected_owner_money = owner.money + subject.hotel_rent
        expected_player_money = player_1.money - subject.hotel_rent
        subject.pay_owner(player_1)
        expect(owner.money).to eq(expected_owner_money)
        expect(player_1.money).to eq(expected_player_money)
      end
    end
  end
end
