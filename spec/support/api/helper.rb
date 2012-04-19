module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end

  RSpec.configure do |c|
    c.include ApiHelper, :type => :api
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end
