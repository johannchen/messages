versesDirectives = angular.module('versesApp.directives', [])
versesDirectives.directive 'appVersion', ['version', (version) ->
    (scope, element, attrs) ->
      element.text(version)
  ]

versesDirectives.directive 'jcEnter', () ->
  (scope, elm, attrs) ->
    elm.bind 'keypress', (e) ->
      scope.$apply(attrs.jcEnter) if e.charCode == 13

versesDirectives.directive 'jcChosen', () ->
  restrict: 'A'
  link: (scope, element, attr) ->
    scope.$watch 'categories', ->
      element.trigger('liszt:updated')
    element.chosen()

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


