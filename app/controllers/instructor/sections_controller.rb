class Instructor::SectionsController < ApplicationController
  def new 
    @course = Course.find(params[:course_id])
    @section = Section.new
  end

  def create
    @course = Course.find(params[:course_id]) ##Load the correct course from our database
    @section = @course.sections.create(section_params) #Create a section in our database, connected to the course the instructor was working with
    redirect_to instructor_course_path(@course) # Redirect the user to the corresponding instructor show course page
  end

  private

  def section_params
    params.require(:section).permit(:title)
  end
end


