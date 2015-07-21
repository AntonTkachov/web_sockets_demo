$(document).on 'ready page:load', ->
  dispatchers = {}
  channels = {}

  $.each [1,2,3], (index, id) ->
    dispatchers[id] = new WebSocketRails('localhost:3000/websocket')
    channels[id] = dispatchers[id].subscribe('chat')

    channels[id].bind 'message', (response) ->
      data = JSON.parse(response)
      if data.user_id != id
        $newLi = $("<li></li>")
        $newLi.html(data.message)
        $('ul.user' + id).append($newLi)

    $('.user' + id + ' a').click (e) ->
      $input = $('.user' + id + ' input')
      message = $input.val()
      $input.val('')
      $.ajax
        url: '/messages'
        type: 'POST'
        data: JSON.stringify(message: message, user_id: id)
        dataType: 'json'
        success: ->
          $newLi = $("<li></li>")
          $newLi.html(message)
          $newLi.addClass('own')
          $('ul.user' + id).append($newLi)

