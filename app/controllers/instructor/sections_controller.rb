class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course

  def new 
      @section = Section.new
  end

  def create
    @section = current_course.sections.create(section_params) #Create a section in our database, connected to the course the instructor was working with
    redirect_to instructor_course_path(current_course) # Redirect the user to the corresponding instructor show course page
  end

  def require_authorized_for_current_course
    if current_course.user != current_user
      render text: "Unauthorized", status: :unauthorized
    end
  end

  private

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:course_id])
  end


  def section_params
    params.require(:section).permit(:title)
  end
end


