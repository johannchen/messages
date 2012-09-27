filterModule = angular.module 'versesApp.filters', []
filterModule.filter 'verseBgColor', ->
  (input, memorized) ->
    colors = ['white', 'moccasin', 'pink', 'coral', 'khaki', 'tan', 'lightblue', 'yellowgreen', 'orchid', 'orange', 'limegreen']
    if memorized > 0 and memorized <= 10
      colors[memorized]
    else if memorized > 10
      'limegreen'
    else
      ''

