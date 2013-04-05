plan_id = location.pathname.split("/")[2]
source = new EventSource("/plans/#{plan_id}/cards/events")
source.addEventListener 'message', (e) ->
  message = $.parseJSON(e.data)
  #$('#card').append($('<li>').text("#{message.point}pt (#{message.note})"))
  console.log message
  $('#card').text("#{message.text}")
