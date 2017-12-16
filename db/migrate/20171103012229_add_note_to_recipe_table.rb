class AddNoteToRecipeTable < ActiveRecord::Migration[5.1]
  def change
   add_column :recipes, :note, :text 
  end
end
