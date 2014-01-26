class Comment < ActiveRecord::Base
  # include Voteable //now included as gem


  include VoteableTomJan

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post

  validates :body, presence: true




end

