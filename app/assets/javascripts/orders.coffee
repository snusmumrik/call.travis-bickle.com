# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if ($('.datetimepicker').length)
    $('.datetimepicker').datetimepicker
      locale: "ja"
      format: "HH:mm"
      sideBySide: true

  if $('#assigned_at').text() == ''
    $('#loading').removeClass('hidden')
  else
    $('#order_back a').removeClass('disabled')
