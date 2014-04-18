class Follow < ActiveRecord::Base
  attr_accessible :user_id, :receiver_id, :status
  belongs_to :user
end
