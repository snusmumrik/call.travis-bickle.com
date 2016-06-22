class ChatController < WebsocketRails::BaseController
  def initialize_session
    logger.debug("initialize chat controller")
  end
 
  def connect_user
    logger.debug("connected user")
  end
 
  def create_message
    logger.debug("Call create_message : #{message}")
    # send_message :new_message, message
    parent_id = message[:parent_id]
    WebsocketRails["#{parent_id}"].trigger(:notify_message, message)
  end

  def update_message
    logger.debug("Call confirm_message : #{message}")
    # send_message :new_message, message
    device_token = message[:device_token]
    WebsocketRails["#{device_token}"].trigger(:confirm_message, message)
  end
end
