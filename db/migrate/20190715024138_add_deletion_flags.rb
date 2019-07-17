class AddDeletionFlags < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deletion_flg, :integer, default: 0
    add_column :questions, :deletion_flg, :integer, default: 0
    add_column :answers, :deletion_flg, :integer, default: 0
    add_column :answer_replies, :deletion_flg, :integer, default: 0
  end
end
