require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8).on(:create) }

    describe '#email' do
      context 'invaid email format' do
        subject { build_stubbed(:user, email: 'this is invalid@email.com') }

        specify do
          expect(subject.valid?).to be_falsey
          expect(subject.errors.messages[:email]).to eq(["is invalid"])
        end
      end

      context 'invalid email format' do
        subject { build_stubbed(:user, email: 'valid@email.com>') }

        specify do
          expect(subject.valid?).to be_falsey
          expect(subject.errors.messages[:email]).to eq(["is invalid"])
        end
      end
      
      context 'valid email format' do
        subject { build_stubbed(:user, email: 'valid@email.com') }

        it { expect(subject.valid?).to be_truthy }
      end
    end
  end
end
