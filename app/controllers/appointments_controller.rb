class AppointmentsController < ApplicationController

  def index
    if current_user.type == "Mentor"
      @appointments = Appointment.where(mentor_id: current_user.id).where('datetime > ?', DateTime.now).order(datetime: :asc)
    elsif current_user.type == "Student"
      @appointments = Appointment.where('datetime > ?', DateTime.now).order(datetime: :asc)
    else
      redirect_to root_path
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.student != nil
      @appointment.update_attributes(student_id: nil)
      redirect_to appointments_path
    else
      @appointment.update_attributes(student_id: current_user.id)
      redirect_to appointment_path
    end

  end

  def show
    @appointment = Appointment.find(params[:id])
    @review = Review.new
    @student = @appointment.student
    @mentor = @appointment.mentor
    @reviews = @appointment.reviews
    @skills = @appointment.skills
    if @reviews.first
      @type = @reviews.first.author.type
    elsif @reviews.last
      @type = @reviews.last.author.type
    else
    end
  end

  def new
    @appointment = Appointment.new
    @skills = Skill.all
  end

  def create
    zone = ActiveSupport::TimeZone.new("Eastern Time (US & Canada)")
    Time.now.in_time_zone(zone)
    @datetime = Time.new(params[:appointment][:datetime][0..3], params[:appointment][:datetime][5..6], params[:appointment][:datetime][8..9], params[:appointment]["datetime(4i)"], params[:appointment]["datetime(5i)"]).in_time_zone(zone)
    @appointment = Appointment.new(datetime: @datetime, mentor_id: current_user.id)
    params[:appointment][:skills].select do |skill, value|
      if value == "1"
        @appointment.skills << Skill.where(name: skill)
      end
    end
    if @appointment.skills.empty?
      render 'new'
    end
    if @appointment.save
      redirect_to appointments_path
    else
      render 'new'
    end
  end


  private
  def appointment_params
    params.require(:appointment).permit(:datetime, :mentor_id)
  end
end
