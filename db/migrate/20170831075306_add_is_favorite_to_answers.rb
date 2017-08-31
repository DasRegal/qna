class AddIsFavoriteToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :is_favorite, :boolean, default: false
  end
end
