class Comment < ActiveRecord::Base
  attr_accessible :text, :ticket_id, :user_id, :user

  belongs_to :user

  validates :text, :presence => true
end
