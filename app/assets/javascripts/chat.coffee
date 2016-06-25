# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @ChatClass
  constructor: (url, useWebsocket) ->
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @device_token = $('#device_token').val()
    @user_id = $('#user_id').val()
    @parent_id = $('#parent_id').val()
    if @user_id == @parent_id
      @admin_channel = @dispatcher.subscribe(@parent_id)
    else if @device_token != undefined
      @client_channel = @dispatcher.subscribe(@device_token)
    @bindEvents()

  bindEvents: () =>
    $('#create').on 'click', @createMessage
    $('#update').on 'click', @updateMessage
    $('#destroy').on 'click', @destroyMessage
    # サーバーから***_messageを受け取ったら***Messageを実行
    if @user_id == @parent_id
      @admin_channel.bind 'notify_message', @notifyMessage
      @admin_channel.bind 'cancel_message', @cancelMessage
    else if @device_token != undefined
      @client_channel.bind 'confirm_message', @confirmMessage

  createMessage: (event) =>
    $('#sound-file1').get(0).play()
    # オブジェクトでデータを指定してサーバ側にsend_messageのイベントを送信
    @dispatcher.trigger 'notify_message', { parent_id: @parent_id }

  notifyMessage: (message) =>
    console.log message
    $('#sound-file2').get(0).play()
    $('.container').eq(0).prepend('<div class="alert alert-success"><p id="notice"></p></div>')
    $('p#notice').hide().html("<a href src='/orders'>新しい配車依頼がありました。詳細はここをクリックして確認してください。3秒後に自動的にページが更新されます。</a>").fadeIn('slow')
    setTimeout (->
      window.location.href = '/orders'
    ), 3000

  updateMessage: (event) =>
    if $('#order_taxis_taxi_id').val() != '' && $('#order_assigned_at').val() != ''
      device_token = $('#order_device_token').val()
      taxi = $('#order_taxis_taxi_id option:selected').text()
      # keyword = $('#order_keyword').val()
      assigned_at = $('#order_assigned_at').val() + '分後'
      # @dispatcher.trigger 'confirm_message', { device_token: device_token, taxi: taxi, keyword: keyword, assigned_at: assigned_at }
      @dispatcher.trigger 'confirm_message', { device_token: device_token, taxi: taxi, assigned_at: assigned_at }

  confirmMessage: (message) =>
    console.log message
    $('#sound-file2').get(0).play()
    $('#taxi').hide().html(message['taxi']).fadeIn('slow')
    # $('#keyword').hide().html(message['keyword']).fadeIn('slow')
    $('#assigned_at').hide().html(message['assigned_at']).fadeIn('slow')
    $('div.alert').hide('slow')
    $('#title').hide().html('配車が確定しました。').fadeIn('slow')
    $('#sub-title').hide().html('車両到着時に合言葉の確認をお願いいたします。').fadeIn('slow')
    $('#loading').hide('slow')
    $('#order_back a').removeClass('disabled')

  destroyMessage: (event) =>
    $('#sound-file2').get(0).play()
    # オブジェクトでデータを指定してサーバ側にsend_messageのイベントを送信
    @dispatcher.trigger 'cancel_message', { parent_id: @parent_id }

  cancelMessage: (message) =>
    console.log message
    $('#sound-file2').get(0).play()
    $('.container').eq(0).prepend('<div class="alert alert-danger"><p id="alert"></p></div>')
    $('p#alert').hide().html("<a href src='/orders'>配車依頼のキャンセルがありました。詳細はここをクリックして確認してください。3秒後に自動的にページが更新されます。</a>").fadeIn('slow')
    setTimeout (->
      window.location.href = '/orders'
    ), 3000

$ ->
  websocket_url = $('#websocket_url').val()
  window.chatClass = new ChatClass(websocket_url, true)

# generate_token = (len)->
#   return "" if len <= 0
#   str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
#   (str[Math.floor(Math.random() * str.length)] for index in [1..len]).join ""
