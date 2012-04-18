class Ticket < ActiveRecord::Base
  searcher do
    label :tag, :from => :tags, :field => :name
    label :state, :from => :state, :field => :name
  end


  belongs_to :project
  belongs_to :user
  belongs_to :state
  has_many :assets
  has_many :comments
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :watchers, :join_table => "ticket_watchers",
    :class_name => "User"

  after_create :creator_watches_me
  accepts_nested_attributes_for :assets

  attr_accessible :description, :title, :user, :assets_attributes, :asset

  validates :title, :presence => true
  validates :description, :presence => true,
                          :length => { :minimum => 10 }

  def tag!(tags)
    tags = tags.split(" ").map do |tag|
      Tag.find_or_create_by_name(tag)
    end

    self.tags << tags
  end

  private

    def creator_watches_me
      self.watchers << user
    end



end
# == Schema Information
#
# Table name: tickets
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  project_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  user_id     :integer
#

