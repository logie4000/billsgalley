class Ingredient < ApplicationRecord
  belongs_to :recipe

  def self.placeholder_text
    return "Enter a new ingredient"
  end
end
