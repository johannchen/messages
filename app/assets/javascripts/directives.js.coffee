directiveModule = angular.module('directives', [])
directiveModule.directive 'appVersion', ['version', (version) ->
    (scope, element, attrs) ->
      element.text(version)
  ]

directiveModule.directive 'jcEnter', ->
  (scope, elm, attrs) ->
    elm.bind 'keypress', (e) ->
      scope.$apply(attrs.jcEnter) if e.charCode == 13

directiveModule.directive 'bibleAutocomplete', ->
  bible = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalm", "Proverbs", "Ecclesiastes", "Song of Songs", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi", "Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"]
  restrict: "A"
  link: (scope, element, attrs) ->
    element.autocomplete source: bible

directiveModule.directive 'fullCalendar', ->
  restrict: 'A'
  replace: true
  transclude: true
  scope: { events: '=' }
  template: "<div id=\"calendar\"></div>"
  link: (scope, element, attrs) ->
    scope.calendar = $('#calendar').fullCalendar
      header:
        left: 'prev,next today'
        center: 'title'
        right: 'month,basicWeek'
      defaultView: 'month'
      editable: false
      height: 500
      loading: (bool) -> 
        if bool then $("#loading").show() else $("#loading").hide()
      events: scope.events
      eventClick: (event) ->
        window.location = '#/show/' + event.id
        false



