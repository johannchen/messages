versesDirectives = angular.module('versesApp.directives', [])
versesDirectives.directive 'appVersion', ['version', (version) ->
    (scope, element, attrs) ->
      element.text(version)
  ]

versesDirectives.directive 'jcEnter', ->
  (scope, elm, attrs) ->
    elm.bind 'keypress', (e) ->
      scope.$apply(attrs.jcEnter) if e.charCode == 13

versesDirectives.directive 'bibleAutocomplete', ->
  bible = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalm", "Proverbs", "Ecclesiastes", "Song of Songs", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi", "Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"]
  restrict: "A"
  link: (scope, element, attrs) ->
    element.autocomplete source: bible

###

versesDirectives.directive 'jcEditableText', () ->
  return {
    restrict: 'A'
    scope: { model: '=' }
    template: '<span ng-hide="editMode" ng-dblclick="editMode=true">{{model}}</span><input type="text" class="span2" autofocus="autofocus" ng-model="model" ng-show="editMode" jc-enter="editMode=false" ng-dblclick="editMode=false" />'
  }

versesDirectives.directive 'jcDraggable', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.draggable(revert: true)

versesDirectives.directive 'jcDroppable', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.droppable
      drop: (event,ui) ->
        scope.verse.categories = [] if typeof scope.verse.categories is "undefined"
        scope.verse.categories.push $.trim(ui.draggable.text())
        scope.$apply()
        ###


