class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_type, :commentable_id
  validates :body, :presence => true
  belongs_to :commentable, :polymorphic => true
end
