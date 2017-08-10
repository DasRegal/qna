class RemoveColsFromAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :is_help, :string
    remove_column :answers, :rating, :string
  end
end
