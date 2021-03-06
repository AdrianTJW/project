require 'will_paginate/array'
class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
    @hosts = Host.all
 
    @hash = Gmaps4rails.build_markers(@jobs) do |job, marker|
      marker.lat job.latitude
      marker.lng job.longitude
      marker.infowindow '<div class="column large-5 medium-5 small-5"><img src=' + job.images[0].large.to_s+'></div>' + '<div class="column large-7 medium-7 small-7">' + '<n3><div class="n4" style="font-size: 25px;">' + job.company_name + "</div>" + job.address + "</n3></div>"
    end

    if params[:query].present?
      @jobs = Job.search(params[:query], page: params[:page])

    else
      @jobs = Job.all.page params[:page]
      # @jobs = Job.all
      # @jobs= @jobs.paginate(per_page: 3, page: params[:page])
    end
  end

  def my_index
    @jobs = Job.where(host_id: current_host.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def autocomplete
    render json: Job.search(params[:query], autocomplete: true, limit: 6).map(&:country)
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @booking = Booking.new
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.update(host_id: current_host.id)

    respond_to do |format|
      if @job.save
        UserMailer.job_email(@job).deliver_now
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(send("#{@job.type.underscore.to_sym}_params"))
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(:company_name, :description, :address, :country, :city, :type, :job_name, :salary, {images: []}, :start_date, :end_date, :host_id, :user_id, :content_id)
  end

  def working_holiday_params
    params.require(:working_holiday).permit(:company_name, :description, :address, :country, :city, :type, :job_name, :salary, {images: []}, :start_date, :end_date, :host_id, :user_id, :content_id)
  end

  def internship_params
    params.require(:internship).permit(:company_name, :description, :address, :country, :city, :type, :job_name, :salary, {images: []}, :start_date, :end_date, :host_id, :user_id, :content_id)
  end

  def volunteering_params
    params.require(:volunteering).permit(:company_name, :description, :address, :country, :city, :type, :job_name, :salary, {images: []}, :start_date, :end_date, :host_id, :user_id, :content_id)
  end

  def bootcamp_params
    params.require(:bootcamp).permit(:company_name, :description, :address, :country, :city, :type, :job_name, :salary, {images: []}, :start_date, :end_date, :host_id, :user_id, :content_id)
  end
end
