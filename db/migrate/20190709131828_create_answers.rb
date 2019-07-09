class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.integer :user_id
      t.text :content
      t.string :image
      t.integer :already_read

      t.timestamps
    end
  end
end
