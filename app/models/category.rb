class Category < ActiveRecord::Base
  validates :name, presence: true,
                   length: { minimum: 5 },
                   uniqueness: true
  has_many :post_categories
  has_many :posts, through: :post_categories
end

