# -*- coding: utf-8 -*-
class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_taxi, only: [:new, :create, :edit, :update]
  before_action :set_amount, only: [:new, :create]
  before_action :set_websocket_url

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.includes(:taxis).where(["parent_id = ?", current_user.id]).order("created_at DESC").with_deleted.page params[:page]
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params.merge(parent_id: current_user.parent_id, user: current_user, keyword: sprintf("%04d", Random.rand(1..9999))))

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: t("messages.order.created") }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if params[:order][:taxis][:taxi_id].blank?
      orders_taxi.destroy if orders_taxi = OrdersTaxi.where(["order_id = ?", @order.id]).first
    else
      unless OrdersTaxi.where(["order_id = ? AND taxi_id = ?", @order.id, params[:order][:taxis][:taxi_id]]).first
        unless @order.taxis.blank?
          orders_taxi = OrdersTaxi.where(["order_id = ?", @order.id]).first
          orders_taxi.destroy
        end
        OrdersTaxi.create(order_id: @order.id, taxi_id: params[:order][:taxis][:taxi_id])
      end
    end

    respond_to do |format|
      params[:order][:assigned_at] = Time.now + params[:order][:assigned_at].to_i * 60 unless params[:order][:assigned_at].blank?
      if @order.update(order_params)
        # send_notification(@order) unless @order.assigned_at.blank? || @order.taxis.first.nil?
        format.html { redirect_to orders_path, notice: t("activerecord.models.order") + t("messages.updated") }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to new_order_url, notice: t("activerecord.models.order") + t("messages.order.destroyed") }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def set_taxi
    @taxis = Taxi.where(["user_id = ?", current_user.id]).all.inject(Array.new) {|a, t| a << [t.name, t.id]; a}
  end

  def set_amount
    @amount_option = []
    for i in 1..5
      @amount_option << ["#{i}台", i]
    end
  end

  def set_websocket_url
    @websocket_url = WEBSOCKET_URL
  end

  # def send_notification(order)
  #   # Environment variables are automatically read, or can be overridden by any specified options. You can also
  #   # conveniently use `Houston::Client.development` or `Houston::Client.production`.
  #   apn = Houston::Client.development
  #   apn.certificate = File.read("public/aps_development.pem")

  #   # An example of the token sent back when a device registers for notifications
  #   token = order.device_token

  #   # Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
  #   notification = Houston::Notification.new(device: token)
  #   notification.alert = "配車依頼確定 車両:#{order.taxis.first.try(:name)} 到着予定時刻:#{order.assigned_at.strftime('%H:%M')} 合言葉:#{order.keyword}}"

  #   # Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
  #   notification.badge = 0
  #   notification.sound = "sosumi.aiff"
  #   notification.category = "INVITE_CATEGORY"
  #   notification.content_available = true
  #   notification.custom_data = {keyword: order.keyword, assigned_at: order.assigned_at, taxi: order.taxis.first.try(:name), message: "配車依頼確定 車両:#{order.taxis.first.try(:name)} 到着予定時刻:#{order.assigned_at.strftime('%H:%M')} 合言葉:#{order.keyword}}"}

  #   # And... sent! That's all it takes.
  #   apn.push(notification)
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:parent_id, :address, :latitude, :longitude, :amount, :time, :keyword, :device_token, :assigned_at, :picked_up_at, :arrived_at)
  end
end
