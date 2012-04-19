class Apis::V1::ProjectsController < Apis::V1::BaseController
  def index
    respond_with(Project.for(current_user))
  end
end
