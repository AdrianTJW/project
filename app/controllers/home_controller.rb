class HomeController < ApplicationController
  def index
  	@jobs = Job.all
  	@volunteer = Job.where(type: Volunteering).order(id: :desc)
  	@bootcamp = Job.where(type: Bootcamp).order(id: :desc)
  	@workholiday = Job.where(type: WorkingHoliday).order(id: :desc)
  	@internship = Job.where(type: Internship).order(id: :desc)
  end
end
