angular.module('versesApp').controller 'VersesCtrl', ($scope, Categories, Category) ->
  $scope.newTag = {}
  ### 
  # idb code
  $scope.tags = idb.all('tags')
  setTimeout (->
    $rootScope.$apply()
  ), 1000
  ###
  #
  $scope.tags = Categories.query() 
  $scope.addTag = () ->
    t = new Categories($scope.newTag)
    t.$save (tag) -> 
      console.log(tag)
      $scope.tags.push(tag)
    #$scope.tags.push(Category.save({name: $scope.tagName}))
    #idb.add('tags', {name:$scope.tagName})
    $scope.newTag= {} 
  $scope.removeTag = (tag) ->
    index = $scope.tags.indexOf(tag)
    $scope.tags.splice(index, 1)
    Category.remove {category_id: tag.id}
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
