class RemoveSolvedFromQuestion < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :solved, :string
  end
end
