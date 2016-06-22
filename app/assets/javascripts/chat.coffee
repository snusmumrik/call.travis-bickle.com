# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @ChatClass
  constructor: (url, useWebsocket) ->
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @device_token = $('#order_device_token').val()
    @parent_id = $('#parent_id').val()
    @admin_channel = @dispatcher.subscribe(@parent_id)
    @client_channel = @dispatcher.subscribe(@device_token)
    @bindEvents()

  bindEvents: () =>
    $('#create').on 'click', @createMessage
    $('#update').on 'click', @updateMessage
    # サーバーからnew_messageを受け取ったらnewMessageを実行
    @admin_channel.bind 'notify_message', @notifyMessage
    @client_channel.bind 'confirm_message', @confirmMessage

  createMessage: (event) =>
    $('#sound-file1').get(0).play()
    # オブジェクトでデータを指定してサーバ側にsend_messageのイベントを送信
    @dispatcher.trigger 'create_message', { parent_id: @parent_id }

  notifyMessage: (message) =>
    console.log message
    $('#sound-file2').get(0).play()
    $('.container').eq(0).prepend('<div class="alert alert-success"><p id="notice"></p></div>')
    $('p#notice').hide().html("<a href src='#' class='refresh'>新しい配車依頼がありました。詳細はここをクリックして確認してください。</a>").fadeIn('slow')

  updateMessage: (event) =>
    if $('#order_taxis_taxi_id').val() != '' && $('#order_assigned_at').val() != ''
      device_token = $('#order_device_token').val()
      taxi = $('#order_taxis_taxi_id option:selected').text()
      assigned_at = $('#order_assigned_at').val()
      @dispatcher.trigger 'update_message', { device_token: device_token, taxi: taxi, assigned_at: assigned_at }

  confirmMessage: (message) =>
    console.log message
    $('#sound-file2').get(0).play()
    $('#taxi').html(message['taxi'])
    $('#assigned_at').html(message['assigned_at'])
    $('div.alert').hide('slow')
    $('#title').html('配車が確定しました。')
    $('#sub-title').html('車両到着時に合言葉の確認をお願いいたします。')
    $('#loading').hide('slow')
    $('#order_back a').removeClass('disabled')

$ ->
  websocket_url = $('#websocket_url').val()
  window.chatClass = new ChatClass(websocket_url, true)

# generate_token = (len)->
#   return "" if len <= 0
#   str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
#   (str[Math.floor(Math.random() * str.length)] for index in [1..len]).join ""
