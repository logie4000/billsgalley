class Recipe < ApplicationRecord
  belongs_to :author, :class_name => "User", :optional => true
  has_and_belongs_to_many :categories
  has_many :ingredients, :dependent => :destroy
  has_many :directions, :dependent => :destroy

  mount_uploader :image, ImageUploader
  validate :image_size_validation

  accepts_nested_attributes_for :ingredients, :allow_destroy => true, :reject_if => proc {|attributes| attributes[:value].blank? || attributes[:value] == Ingredient.placeholder_text }
  accepts_nested_attributes_for :directions, :allow_destroy => true, :reject_if => proc {|attributes| attributes[:step].blank? || attributes[:step] == Direction.placeholder_text }

  validates :title, :presence => :true

  def fullname
    return "#{self.first_name} #{self.last_name}"
  end 

private
  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end

end


