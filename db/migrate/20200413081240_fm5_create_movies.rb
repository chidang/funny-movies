class Fm5CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :title
      t.text :description
      t.string :youtube_video_id
      t.string :youtube_url
      t.integer :user_id

      t.timestamps
    end
  end
end
