angular.module('versesApp').controller 'VersesCtrl', ($scope, Category) ->
  ### 
  # idb code
  $scope.tags = idb.all('tags')
  setTimeout (->
    $rootScope.$apply()
  ), 1000
  ###
  #
  $scope.tags = Category.query() 
  $scope.addTag = () ->
    $scope.tags.push({name: $scope.tagName})
    #idb.add('tags', {name:$scope.tagName})
    $scope.tagName = ''
  $scope.removeTag = (tag) ->
    index = $scope.tags.indexOf(tag)
    $scope.tags.splice(index, 1)
    #idb.delete('tags', tag.id)

  # update tag when value change (id stay the same)
  ### 
  $scope.$watch 'tags', ((newValue, oldValue) ->
    if newValue.length == oldValue.length
      newTags = newValue.filter (obj) ->
        obj not of oldValue
      console.log(newTags)
        #idb.put('tags', newValue, tag.id)
  ), true
  ###
