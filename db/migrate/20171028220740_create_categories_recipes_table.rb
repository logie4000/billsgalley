class CreateCategoriesRecipesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_recipes, id: false do |t|
      t.belongs_to :category, foreign_key: true, index: true
      t.belongs_to :recipe, foreign_key: true, index: true
    end
  end
end
