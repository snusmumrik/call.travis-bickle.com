class SessionsController < Devise::SessionsController
  @@email = nil
  @@password = nil

  def new
    @email = @@email
    @password = @@password
    super
  end

  def create
    super do |resource|
      resource.ensure_authentication_token if request.format.json?
      if params[:user][:remember_me]
        @@email = params[:user][:email]
        @@password = params[:user][:password]
      else
        @@email = nil
        @@password = nil
      end
    end
  end
end
