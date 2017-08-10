class RemoveQuestionIdFromAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :question_id, :string
  end
end
