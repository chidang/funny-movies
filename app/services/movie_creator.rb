class MovieCreator

  YOUTUBE_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  def initialize(params:, user_id:, movie: nil)
    @params = params
    @user_id = user_id
    @messages = {}
    @success = false
    @movie = movie || Movie.new(params)
  end

  def perform
    if @params[:youtube_url].present? && @params[:youtube_url].match(YOUTUBE_LINK_FORMAT)
      create_or_update_movie
    else
      @messages[:danger] = 'Please enter Youtube Video URL'
    end
    [@success, @messages]
  end

  private

  def create_or_update_movie
    if youtube_video&.available?
      set_movie_data
      save_movie
    else
      @messages[:danger] = 'Video is not available'
    end
  end

  def set_movie_data
    @movie.user_id = @user_id
    @movie.title = youtube_video.title
    @movie.youtube_url = @params[:youtube_url]
    @movie.youtube_video_id = youtube_video.video_id
    @movie.description = youtube_video.description
  end

  def save_movie
    success_message = @movie.persisted? ? 'Movie was successfully updated.' : 'Movie was successfully created.'
    if @movie.save
      @success = true
      @messages[:success] = success_message
    else
      @messages[:danger] = @movie.errors.to_a.join(', ')
    end
  end

  def youtube_video
    @video ||= VideoInfo.new(@params[:youtube_url])
  rescue
    nil
  end
end
