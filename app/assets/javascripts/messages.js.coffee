# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#jQuery ->
#  $("#message_category_tokens").tokenInput "/categories.json",
#    crossDomain: false
#    prePopulate: $("#message_category_tokens").data("pre")
#    theme: "facebook"
#

jQuery ->
  $("#calendar").fullCalendar
    editable: false
    header:
      left: 'prev,next today'
      center: 'title'
    defaultView: 'month'
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
  $("#message_form").validate
    rules:
      message_mdate:
        required: true
        dateISO: true
        
