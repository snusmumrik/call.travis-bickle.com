class ChatController < WebsocketRails::BaseController
  def initialize_session
    logger.debug("initialize chat controller")
  end
 
  def connect_user
    logger.debug("connected user")
  end
 
  # def new_message
  #   logger.debug("Call new_message : #{message}")
  #   # send_message :new_message, message
  # end

  def update_message
    logger.debug("Call update_message : #{message}")
    # send_message :new_message, message
    device_token = message[:device_token]
    WebsocketRails["#{device_token}"].trigger(:update_message, message)
  end
end
