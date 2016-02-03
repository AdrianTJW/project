class HomeController < ApplicationController
  def index
  	@jobs = Job.all
  	@volunteer = Job.where(type: Volunteering)
  	@bootcamp = Job.where(type: Bootcamp)
  	@workholiday = Job.where(type: WorkingHoliday)
  	@internship = Job.where(type: Internship)
  end
end
