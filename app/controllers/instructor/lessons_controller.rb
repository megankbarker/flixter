class Instructor::LessonsController < ApplicationController

  before_action :authenticate_user!

  def new
    @section = Section.find(params[:section_id]) # need to load the section that is being referenced in the URL, by pulling the section_id from the param
    if @section.course.user != current_user
      return render text: 'Unauthorized', status: :unauthorized # By sending the unauthorized HTTP code, the browser becomes aware that the request was not successful and exits the function not executing line below
    end
    @lesson = Lesson.new # before we add form to the view, we need to give the form a template object for the thing we're building the form for
  end

  def create 
    @section = Section.find(params[:section_id]) # Look up the section in the database the lesson is for.
    @lesson = @section.lessons.create(lesson_params) # Create the lesson in the database and connect it to the section we looked up.
    redirect_to instructor_course_path(@section.course) #Redirect the user to the instructor dashboard.

  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end
end
