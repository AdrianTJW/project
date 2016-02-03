class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    if current_user
      @bookings = current_user.bookings.all
    end

    if current_host
      @job = Job.find_by(id: params[:job_id])
      @bookings = @job.bookings
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    if @booking.job.type == "Volunteering" || @booking.job.type == "Bootcamp"
      @booking.update(acceptance: true)
      UserMailer.booking1_email(@booking).deliver_now
    end

    respond_to do |format|
      if @booking.save
        UserMailer.booking_email(@booking).deliver_now
        format.html { redirect_to jobs_path, notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: jobs_path }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    @booking = Booking.find_by(id: params[:id])
    @booking.update(acceptance: true)
    UserMailer.confirm_email(@booking).deliver_now
    redirect_to job_bookings_path(params[:job_id]), notice: 'Application was successfully updated.' 
    # respond_to do |format|
    #   if @booking.update(booking_params)
    #     format.html { redirect_to @booking, notice: 'Application was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @booking }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @booking.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to user_bookings_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.permit(:user_id, :job_id, :acceptance)
    end
end
