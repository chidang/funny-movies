class Fm2CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
