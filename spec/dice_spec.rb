# frozen_string_literal: true
require 'spec_helper'

module Game
  describe Dice do
    subject { described_class.new(options)}
    let(:options) { { dice_output: [4,5,1,3] } }

    context '#initalize' do
      it 'creates a new object' do
        expect(subject).to be_a_kind_of(Dice)
      end
    end

    context '#roll' do
      it 'returns the first new position' do
        expect(subject.roll).to eq(4)
      end

      it 'rolled twice returns next position' do
        subject.roll
        expect(subject.roll).to eq(5)
      end
    end
  end
end
