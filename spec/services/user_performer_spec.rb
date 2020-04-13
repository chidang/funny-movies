require 'rails_helper'

describe UserPerformer do
  let(:email) { 'chid@example.com' }
  let(:password) { '12345678' }
  let(:params) do
    {
      email: email,
      password: password
    }
  end

  subject { described_class.new(params) }

  describe '#perform' do
    context 'when user is existing' do
      let!(:user) { create(:user, email: 'chid@example.com', password: '123456789abc')}

      context 'when password is wrong' do
        specify do
          expect(subject.perform).to match_array([{} , {danger: 'Wrong password. Please try again.'}])
        end
      end

      context 'when password is correct' do
        let(:password) { '123456789abc' }

        specify do
          expect(subject.perform).to match_array([{user_email: 'chid@example.com', user_id: user.id} , {}])
        end
      end
    end

    context 'when user is not existing' do
      context 'and params valid' do
        specify do
          expect do
            subject.perform
          end.to change(User, :count).by(1)

          expect(subject.logged_in_data).to eq ({ user_email: 'chid@example.com', user_id: User.last.id })
          expect(subject.messages).to eq({})
        end
      end

      context 'and params is not valid' do
        let(:email) { '' }

        specify do
          expect do
            subject.perform
          end.to change(User, :count).by(0)

          expect(subject.logged_in_data).to eq ({ })
          expect(subject.messages).to eq({danger: 'Email can\'t be blank, Email is invalid'})
        end
      end
    end
  end
end
