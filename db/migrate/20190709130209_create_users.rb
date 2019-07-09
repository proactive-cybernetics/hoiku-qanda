class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :image
      t.text :profile
      t.string :title
      t.integer :title_setting
      t.integer :admin_auth

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
