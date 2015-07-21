$(document).on 'ready page:load', ->
  user1_dispatcher = new WebSocketRails('localhost:3000/websocket')
  user2_dispatcher = new WebSocketRails('localhost:3000/websocket')
  user3_dispatcher = new WebSocketRails('localhost:3000/websocket')

  user1_channel = user1_dispatcher.subscribe('chat')
  user2_channel = user2_dispatcher.subscribe('chat')
  user3_channel = user3_dispatcher.subscribe('chat')

  user1_channel.bind 'message', (response) ->
    data = JSON.parse(response)
    if data.user_id != 1
      $newLi = $("<li></li>")
      $newLi.html(data.message)
      $('ul.user1').append($newLi)

  user2_channel.bind 'message', (response) ->
    data = JSON.parse(response)
    if data.user_id != 2
      $newLi = $("<li></li>")
      $newLi.html(data.message)
      $('ul.user2').append($newLi)

  user3_channel.bind 'message', (response) ->
    data = JSON.parse(response)
    if data.user_id != 3
      $newLi = $("<li></li>")
      $newLi.html(data.message)
      $('ul.user3').append($newLi)

  $('.user1 a').click (e) ->
    message = $('.user1 input').val()
    $('.user1 input').val('')
    $.ajax
      url: '/messages'
      type: 'POST'
      data: JSON.stringify(message: message, user_id: 1)
      dataType: 'json'
      success: ->
        $newLi = $("<li></li>")
        $newLi.html(message)
        $newLi.addClass('own')
        $('ul.user1').append($newLi)

  $('.user2 a').click (e) ->
    message = $('.user2 input').val()
    $('.user2 input').val('')
    $.ajax
      url: '/messages'
      type: 'POST'
      data: JSON.stringify(message: message, user_id: 2)
      dataType: 'json'
      success: ->
        $newLi = $("<li></li>")
        $newLi.html(message)
        $newLi.addClass('own')
        $('ul.user2').append($newLi)

  $('.user3 a').click (e) ->
    message = $('.user3 input').val()
    $('.user3 input').val('')
    $.ajax
      url: '/messages'
      type: 'POST'
      data: JSON.stringify(message: message, user_id: 3)
      dataType: 'json'
      success: ->
        $newLi = $("<li></li>")
        $newLi.html(message)
        $newLi.addClass('own')
        $('ul.user3').append($newLi)
