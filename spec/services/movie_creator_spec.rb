require 'rails_helper'

describe MovieCreator do
  let!(:user) { create(:user) }
  let(:youtube_url) { 'https://www.youtube.com/watch?v=123456' }
  let(:params) { { youtube_url: youtube_url } }

  subject { described_class.new(params, user.id) }

  let(:video_info){ instance_double(VideoInfo) }

  describe '#perform' do
    context 'when Youtube URL present and correct format' do
      context 'and video is available' do
        before do
          allow(VideoInfo).to receive(:new).with(youtube_url).and_return(video_info)
          allow(video_info).to receive(:available?).and_return(true)
          allow(video_info).to receive(:title).and_return('Star wars')
          allow(video_info).to receive(:description).and_return('Star wars description')
          allow(video_info).to receive(:video_id).and_return('123')
        end

        specify do
          expect do
              subject.perform
          end.to change(Movie, :count).by(1)

          expect(subject.perform).to eq ([true, {success: 'Movie was successfully created.'}])
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
