class ChatController < WebsocketRails::BaseController
  def initialize_session
    logger.debug("initialize chat controller")
  end
 
  def connect_user
    logger.debug("connected user")
  end
 
  def notify_message
    logger.debug("Call notify_message : #{message}")
    # send_message :new_message, message
    parent_id = message[:parent_id]
    WebsocketRails["#{parent_id}"].trigger(:notify_message, message)
  end

  def confirm_message
    logger.debug("Call confirm_message : #{message}")
    # send_message :new_message, message
    device_token = message[:device_token]
    WebsocketRails["#{device_token}"].trigger(:confirm_message, message)
  end

  def cancel_message
    logger.debug("Call cancel_message : #{message}")
    parent_id = message[:parent_id]
    WebsocketRails["#{parent_id}"].trigger(:cancel_message, message)
  end
end
