class CreateAnswerReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_replies do |t|
      t.integer :answer_id
      t.text :content
      t.integer :already_read

      t.timestamps
    end
  end
end
