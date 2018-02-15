# frozen_string_literal: true
require 'spec_helper'

module Game
  describe Hotel do
    let(:hotel) { double :hotel }
    let(:hotel_id) { 1 }
    let(:rent) { 10 }
    let(:worth) {100}

    context '#initalize' do
      it 'creates a new object' do
        expect(Hotel).to receive(:new).with(hotel_id, rent, worth).and_return(hotel)

        Hotel.new(hotel_id, rent, worth)
      end
    end

    context '#show' do
      let(:hotel_hash) { 'hotel_hash' }

      it 'returns the hotel hash' do
        expect_any_instance_of(Hotel).to receive(:show).and_return(hotel_hash)

        h = Hotel.new(hotel_id, rent, worth)
        h.show
      end
    end
  end
end
