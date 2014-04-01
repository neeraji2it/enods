class CauseFan < ActiveRecord::Base
  attr_accessible :cause_id, :user_id, :status
  belongs_to :user
  belongs_to :cause
end
