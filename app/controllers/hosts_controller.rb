class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]

  # GET /hosts/1
  # GET /hosts/1.json
  def show
    @host = Host.find_by(id: current_host.id)
  end

  # GET /hosts/1/edit
  def edit
        respond_to do |format|
        format.html
        format.js
      end
  end

  # PATCH/PUT /hosts/1
  # PATCH/PUT /hosts/1.json
  def update
    respond_to do |format|
      if @host.update(host_params)
        format.html { redirect_to @host, notice: 'Host was successfully updated.' }
        format.json { render :show, status: :ok, location: @host }
      else
        format.html { render :edit }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    @host.destroy
    respond_to do |format|
      format.html { redirect_to hosts_url, notice: 'Host was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host
      @host = Host.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def host_params
      params.require(:host).permit(:fullname, :email, :image, :contact)
    end
end
