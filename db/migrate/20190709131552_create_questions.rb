class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :user_id
      t.text :content
      t.string :image
      t.integer :best_answer
      t.integer :status

      t.timestamps
    end
  end
end
