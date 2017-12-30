require 'rails_helper'

RSpec.describe Script, type: :model do
  describe '#title' do
    context 'normal cases' do
      context 'when larger than 1B and smaller than 1KB' do
        it{ expect( build(:script, title: 'title').validate ).to be_truthy }
      end
    end

    context 'error cases' do
      context 'when given nil' do
        it{ expect( build(:script, title: nil).validate ).to be_falsey }
      end

      context 'when given empty' do
        it{ expect( build(:script, title: '').validate ).to be_falsey }
      end

      context 'when given larger than 1KB' do
        it{ expect( build(:script, title: 'a' + 'a' * 1.kilobytes).validate ).to be_falsey }
      end
    end
  end

  describe '#body' do
    context 'normal cases' do
      context 'when larger than 1B and smaller than 4MB' do
        it{ expect( build(:script, body: 'body').validate ).to be_truthy }
      end
    end

    context 'error cases' do
      context 'when given nil' do
        it{ expect( build(:script, body: nil).validate ).to be_falsey }
      end

      context 'when given empty' do
        it{ expect( build(:script, body: '').validate ).to be_falsey }
      end

      context 'when given larger than 4MB' do
        it{ expect( build(:script, body: 'a' + 'a' * 4.megabytes).validate ).to be_falsey }
      end
    end
  end
end
