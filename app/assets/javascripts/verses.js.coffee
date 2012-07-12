# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

VerseCtrl = ($scope) ->
  $scope.verses = [
    ref: "John 3:16"
  ,
    ref: "Romans 12:1-2"
  ]
  $scope.addVerse = ->
    $scope.verses.push(ref: $scope.newVerse)
    $scope.newVerse = ""

