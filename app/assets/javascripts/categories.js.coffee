# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.best_in_place').best_in_place()

  split = (val) -> val.split /,\s*/
  extractLast = (term) -> split(term).pop()
  $("#message_category_names,#verse_category_names")
    .bind "keydown", (event) ->
      if event.keyCode == $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active
        event.preventDefault
    .autocomplete
        minLength: 0
        source: (request, response) ->
          $.getJSON "/categories", 
            term: extractLast request.term
            response
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
