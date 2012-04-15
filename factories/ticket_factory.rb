Factory.define :ticket do |ticket|
  ticket.title "A ticket"
  ticket.description "A ticket, noting more"
  ticket.user { |u| u.association(:user) }
  ticket.project { |p| p.association(:project) }
end
