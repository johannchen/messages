angular.module('versesApp').controller 'VersesCtrl', ($scope, idb, $rootScope) ->
  $scope.tags = idb.all('tags')
  setTimeout (->
    $rootScope.$apply()
  ), 1000
  $scope.addTag = () ->
    $scope.tags.push({name: $scope.tagName})
    idb.add('tags', {name:$scope.tagName})
    $scope.tagName = ''




