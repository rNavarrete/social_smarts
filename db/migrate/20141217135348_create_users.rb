class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :provider
        t.string :uid
        t.string :name
        t.string :image
        t.string :oauth_token
        t.string :oauth_secret
    end
  end
end
