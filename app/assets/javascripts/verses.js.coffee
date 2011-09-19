# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  books = ["Matthew", "Mark", "Luke", "John"]
  split = (val) -> val.split /,\s*/
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
          this.value = terms.join ", "
          false

