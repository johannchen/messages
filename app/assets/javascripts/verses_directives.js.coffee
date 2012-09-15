angular.module('versesApp.directives', []).
  directive 'appVersion', ['version', (version) ->
    (scope, element, attrs) ->
      element.text(version)
  ]
