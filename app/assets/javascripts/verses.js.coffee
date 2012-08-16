# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.module = angular.module('Verses', ['ngResource'])

# allow CSRF
window.module.config [ "$httpProvider", (provider) ->
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

window.VersesCtrl = ($scope, $resource) ->
  Verse = $resource('verses.json')
  $scope.verses = Verse.query()
  $scope.addVerse = ->
    #$scope.verses.push(ref: $scope.newVerse)
    # save new verse in server
    verse = $resource 'verses', {},
      save:
        method: 'POST'
        params: 
          ref: $scope.newVerse
          user_id: 1
          favorite: true
    
    $scope.verses.push(verse.save())
    $scope.newVerse = ""
