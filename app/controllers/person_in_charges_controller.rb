class PersonInChargesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_person_in_charge, only: [:show, :edit, :update, :destroy]

  # GET /person_in_charges
  # GET /person_in_charges.json
  def index
    @person_in_charges = PersonInCharge.page params[:page]
  end

  # GET /person_in_charges/1
  # GET /person_in_charges/1.json
  def show
  end

  # GET /person_in_charges/new
  def new
    @person_in_charge = PersonInCharge.new
  end

  # GET /person_in_charges/1/edit
  def edit
  end

  # POST /person_in_charges
  # POST /person_in_charges.json
  def create
    @person_in_charge = PersonInCharge.new(person_in_charge_params.merge(user: current_user))

    respond_to do |format|
      if @person_in_charge.save
        format.html { redirect_to @person_in_charge, notice: 'Person in charge was successfully created.' }
        format.json { render :show, status: :created, location: @person_in_charge }
      else
        format.html { render :new }
        format.json { render json: @person_in_charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /person_in_charges/1
  # PATCH/PUT /person_in_charges/1.json
  def update
    respond_to do |format|
      if @person_in_charge.update(person_in_charge_params)
        format.html { redirect_to @person_in_charge, notice: 'Person in charge was successfully updated.' }
        format.json { render :show, status: :ok, location: @person_in_charge }
      else
        format.html { render :edit }
        format.json { render json: @person_in_charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person_in_charges/1
  # DELETE /person_in_charges/1.json
  def destroy
    @person_in_charge.destroy
    respond_to do |format|
      format.html { redirect_to person_in_charges_url, notice: 'Person in charge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person_in_charge
      @person_in_charge = PersonInCharge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_in_charge_params
      params.require(:person_in_charge).permit(:user_id, :name)
    end
end
