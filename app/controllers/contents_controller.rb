class ContentsController < ApplicationController
  def index
    # redirect_to orders_path if user_signed_in?
    # redirect_to new_order_path if customer_signed_in?
  end

  def show
    if params[:id] && File.exist?(path = "#{Rails.root.to_s}/app/views/contents/#{params[:id]}.html.haml")
      # case params[:id]
      # when ""
      # end
      render :file => path, :layout => true
    else
      render :text => "Page does not exists.", :status => 404
    end
  end
end
