class TaxisController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_taxi, only: [:show, :edit, :update, :destroy]

  # GET /taxis
  # GET /taxis.json
  def index
    @taxis = Taxi.order("name").page params[:page]
  end

  # GET /taxis/1
  # GET /taxis/1.json
  def show
  end

  # GET /taxis/new
  def new
    @taxi = Taxi.new
  end

  # GET /taxis/1/edit
  def edit
  end

  # POST /taxis
  # POST /taxis.json
  def create
    @taxi = Taxi.new(taxi_params.merge(user: current_user))

    respond_to do |format|
      if @taxi.save
        format.html { redirect_to @taxi, notice: t("activerecord.models.taxi") + t("messages.created") }
        format.json { render :show, status: :created, location: @taxi }
      else
        format.html { render :new }
        format.json { render json: @taxi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taxis/1
  # PATCH/PUT /taxis/1.json
  def update
    respond_to do |format|
      if @taxi.update(taxi_params)
        format.html { redirect_to @taxi, notice: t("activerecord.models.taxi") + t("messages.updated") }
        format.json { render :show, status: :ok, location: @taxi }
      else
        format.html { render :edit }
        format.json { render json: @taxi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taxis/1
  # DELETE /taxis/1.json
  def destroy
    @taxi.destroy
    respond_to do |format|
      format.html { redirect_to taxis_url, notice: t("activerecord.models.taxi") + t("messages.destroyed") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_taxi
      @taxi = Taxi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def taxi_params
      params.require(:taxi).permit(:user_id, :name, :type_name)
    end
end
