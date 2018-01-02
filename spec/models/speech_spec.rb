require 'rails_helper'

RSpec.describe Speech, type: :model do
  describe '#url' do
    context 'normal cases' do
      context 'when larger than 1B and smaller than 128KB' do
        it{ expect( build(:speech, url: 'url').validate ).to be_truthy }
      end
    end

    context 'error cases' do
      context 'when given nil' do
        it{ expect( build(:speech, url: nil).validate ).to be_falsey }
      end

      context 'when given empty' do
        it{ expect( build(:speech, url: '').validate ).to be_falsey }
      end

      context 'when given larger than 128KB' do
        it{ expect( build(:speech, url: 'a' + 'a' * 128.kilobytes).validate ).to be_falsey }
      end
    end
  end

  describe '#size' do
    context 'normal cases' do
      context 'when greater than 0' do
        it{ expect( build(:speech, size: 1).validate ).to be_truthy }
      end

      context 'when given 0' do
        it{ expect( build(:speech, size: 0).validate ).to be_truthy }
      end
    end

    context 'error cases' do
      context 'when given nil' do
        it{ expect( build(:speech, size: nil).validate ).to be_falsey }
      end

      context 'when given non-positive integer' do
        it{ expect( build(:speech, size: -1).validate ).to be_falsey }
      end
    end
  end
end
