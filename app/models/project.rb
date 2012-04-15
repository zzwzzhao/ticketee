class Project < ActiveRecord::Base
  attr_accessible :name

  has_many :tickets, :dependent => :destroy
  has_many :permissions, :as => :thing
  scope:readable_by, lambda { |user|
    joins(:permissions).where(:permissions => { :action => "view",
                                                :user_id => user.id})
  }

  validates :name, :presence => true, :uniqueness => true

  def self.for(user)
    user.admin? ? Project : Project.readable_by(user)
  end
end
