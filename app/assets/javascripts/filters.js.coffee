filterModule = angular.module 'filters', []
filterModule.filter 'verseBgColor', ->
  (input, memorized) ->
    colors = ['white', 'moccasin', 'pink', 'coral', 'khaki', 'tan', 'lightblue', 'yellowgreen', 'orchid', 'orange', 'limegreen']
    if memorized > 0 and memorized <= 10
      colors[memorized]
    else if memorized > 10
      'limegreen'
    else
      ''

filterModule.filter 'labelCategory', ->
  (input, active) ->
    if active then 'label-success' else 'label-info'

filterModule.filter 'labelSpeaker', ->
  (input, active) ->
    if active then 'label-success' else 'label'

