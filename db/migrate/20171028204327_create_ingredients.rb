class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.integer :position
      t.string :value
      t.belongs_to :recipe, foreign_key: true

      t.timestamps
    end
  end
end
