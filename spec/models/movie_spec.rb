require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe '.associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe '.validations' do
    it { is_expected.to validate_presence_of(:youtube_url) }
  end

  describe '.delegations' do
    it { is_expected.to delegate_method(:email).to(:user).with_prefix }
  end
end
