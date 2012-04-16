class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  attr_accessible :description, :title, :user, :asset

  validates :title, :presence => true
  validates :description, :presence => true,
                          :length => { :minimum => 10 }
  has_attached_file :asset,
     :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
     :url => "/system/:attachment/:id/:style/:filename"



end
