class Direction < ApplicationRecord
  belongs_to :recipe

  def self.placeholder_text
    return "Enter a new direction"
  end
end
