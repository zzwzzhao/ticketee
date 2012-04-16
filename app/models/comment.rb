class Comment < ActiveRecord::Base
  after_create :set_ticket_state
  attr_accessible :text, :ticket_id, :user_id, :user, :state_id

  belongs_to :user
  belongs_to :state
  belongs_to :ticket
  delegate :project, :to => :ticket

  validates :text, :presence => true

  private

    def set_ticket_state
      self.ticket.state = self.state
      self.ticket.save!
    end
end
