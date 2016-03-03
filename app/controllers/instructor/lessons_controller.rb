class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: [:create]
  before_action :require_authorized_for_current_lesson, only: [:update]

 
  def create 
    @lesson = current_section.lessons.create(lesson_params) # Create the lesson in the database and connect it to the section we looked up.
    redirect_to instructor_course_path(current_section.course) #Redirect the user to the instructor dashboard.
  end

  def update
    current_lesson.update_attributes(lesson_params)
    render text: 'updated!'
  end

  private

  def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
    render text: 'Unauthorized', status: :unauthorized
    end
  end 

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_section
    if current_section.course.user != current_user
       render text: 'Unauthorized', status: :unauthorized # By sending the unauthorized HTTP code, the browser becomes aware that the request was not successful and exits the function not executing line below
    end
  end

  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video, :row_order_position)
  end
end
