# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  $("#calendar").fullCalendar
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'month,basicWeek'
    defaultView: 'month'
    editable: false
    height: 500
    loading: (bool) -> 
      if bool then $("#loading").show() else $("#loading").hide()
    events: "/messages/calendar"
    eventClick: (event) ->
      window.location = '/messages/' + event.id
      false

  $("#message_mdate").datepicker dateFormat: 'yy-mm-dd'
  $("#message_listened_on").datepicker dateFormat: 'yy-mm-dd'
  $("#message_speaker_name").autocomplete source: "/speakers"
  $("#message_note").cleditor()

  $('#add-verse-link').click ->
    $('#verse_fields').append("<li><input type='text' name='message[verse_refs][]' /></li>")
        
