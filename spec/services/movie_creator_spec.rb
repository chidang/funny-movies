require 'rails_helper'

describe MovieCreator do
  let!(:user) { create(:user) }
  let(:params) { { youtube_url: 'https://www.youtube.com/watch?v=x3T-1wJCtFI' } }

  subject { described_class.new(params, user.id) }

  describe '#perform' do
    context 'when Youtube URL present and correct format' do
      context 'and video is available' do
        before do
          allow_any_instance_of(VideoInfo).to receive(:available?).and_return(true)
          allow_any_instance_of(VideoInfo).to receive(:title).and_return('Star wars')
          allow_any_instance_of(VideoInfo).to receive(:description).and_return('Star wars description')
          allow_any_instance_of(VideoInfo).to receive(:video_id).and_return('123')
        end

        specify do
          expect do
              subject.perform
          end.to change(Movie, :count).by(1)

          expect(subject.messages).to eq ({success: 'Movie was successfully created.'})
          expect(subject.success).to eq true
        end
      end

      context 'and video is not available' do
        before do
          allow_any_instance_of(VideoInfo).to receive(:available?).and_return(false)
        end

        specify do
          expect(subject.perform).to match_array([false , {danger: 'Video is not available'}])
        end
      end
    end

    context 'when Youtube video is not present' do
      let(:params) { { youtube_url: nil } }

      specify do
        expect(subject.perform).to match_array([false , {danger: 'Please enter Youtube Video URL'}])
      end
    end

    context 'when Youtube video url format is not correct' do
      let(:params) { { youtube_url: 'https://www.youtube.com?v=x3T-1wJCtFI' } }

      specify do
        expect(subject.perform).to match_array([false , {danger: 'Please enter Youtube Video URL'}])
      end
    end
  end
end
