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
  books = [
    "Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy"
    "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel"
    "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles"
    "Ezra", "Nehemiah", "Esther"
    "Job", "Psalms", "Proverbs", "Ecclesiastes", "Song of Songs"
    "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel"
    "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah"
    "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi"
    "Matthew", "Mark", "Luke", "John", "Acts"
    "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians"
    "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians"
    "1 Timothy", "2 Timothy", "Titus", "Philemon"
    "Hebrews", "James", "1 Peter", "2 Peter"
    "1 John", "2 John", "3 John", "Jude", "Revelation"
  ]

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

  split = (val) -> val.split /;\s*/
  extractLast = (term) -> split(term).pop()
  $("#message_verse_refs")
    .bind "keydown", (event) ->
      if event.keyCode == $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active
        event.preventDefault
    .autocomplete
        minLength: 0
        source: (request, response) ->
          # delegate back to autocomplete, but extract the last term
          response $.ui.autocomplete.filter books, 
            extractLast request.term
        focus: -> false
        select: (event, ui) ->
          terms = split(this.value)
          # remove the current input
          terms.pop()
          # add the selected item
          terms.push ui.item.value
          # add placeholder to get the comma-and-space at the end
          terms.push ""
          this.value = terms.join "; "
          false

  $("#message_form").validate
    rules:
      message_mdate:
        required: true
        dateISO: true
        
