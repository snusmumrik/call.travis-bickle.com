# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @ChatClass
  constructor: (url, useWebsocket) ->
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @device_token = $('#order_device_token').val()
    @channel = @dispatcher.subscribe(@device_token)
    console.log(url)
    @bindEvents()

  bindEvents: () =>
    # $('#send').on 'click', @sendMessage
    $('#order_submit').on 'click', @updateMessage
    # サーバーからnew_messageを受け取ったreceiveMessageを実行
    @channel.bind 'update_message', @receiveMessage

  sendMessage: (event) =>
    # alert 'send'
    # $('#sound-file1').get(0).play()
    # サーバ側にsend_messageのイベントを送信
    # オブジェクトでデータを指定
    # temporary
    # @device_token = generate_token(40)
    # $('#order_device_token').val(@device_token)
    # @channel.trigger 'new_message', { device_token: @device_token }

  updateMessage: (event) =>
    # alert 'update'
    if $('#order_taxis_taxi_id').val() != '' && $('#order_assigned_at').val() != ''
      device_token = $('#order_device_token').val()
      taxi = $('#order_taxis_taxi_id option:selected').text()
      assigned_at = $('#order_assigned_at').val()
      @dispatcher.trigger 'update_message', { device_token: device_token, taxi: taxi, assigned_at: assigned_at }

  receiveMessage: (message) =>
    # alert 'receive'
    $('#sound-file3').get(0).play()
    console.log message
    $('#taxi').html(message['taxi'])
    $('#assigned_at').html(message['assigned_at'])
    $('div.alert').hide('slow')
    $('#title').html('配車が確定しました。')
    $('#sub-title').html('車両到着時に合言葉の確認をお願いいたします。')
    $('#loading').hide('slow')
    $('#order_back a').removeClass('disabled')

$ ->
  if window.location.href.match(/orders\/[0-9]+/) || window.location.href.match(/orders\/[0-9]+\/edit/)
    websocket_url = $('#websocket_url').val()
    window.chatClass = new ChatClass(websocket_url, true)

# generate_token = (len)->
#   return "" if len <= 0
#   str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
#   (str[Math.floor(Math.random() * str.length)] for index in [1..len]).join ""
