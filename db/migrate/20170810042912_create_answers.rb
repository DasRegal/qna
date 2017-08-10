class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :title
      t.text :body
      t.boolean :is_help, default: false
      t.integer :rating, default: 0

      t.timestamps
    end
  end
end
