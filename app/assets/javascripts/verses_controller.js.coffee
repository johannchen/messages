angular.module('versesApp').controller 'VersesCtrl', ($scope, idb, $rootScope) ->
  $scope.tags = idb.all('tags')
  setTimeout (->
    $rootScope.$apply()
  ), 1000
  $scope.addTag = () ->
    $scope.tags.push({name: $scope.tagName})
    idb.add('tags', {name:$scope.tagName})
    $scope.tagName = ''
  $scope.removeTag = (tag) ->
    index = $scope.tags.indexOf(tag)
    $scope.tags.splice(index, 1)
    idb.delete('tags', tag.id)
  ###
  $scope.$watch 'tag', ((newValue, oldValue) ->
    idb.put('tags', newValue, tag.id)
  ), true
  ###
