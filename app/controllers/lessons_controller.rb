class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]


  def show
    @lesson = Lesson.find(params[:id])
  end

  private
  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def enrolled_in?(course)
    return enrolled_courses.include?(course)
  end

  def require_authorized_for_current_lesson ## "before" filter method
    if ! current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_lesson.section.course), alert: 'You must enroll to view this course.'
    end
  end

end
