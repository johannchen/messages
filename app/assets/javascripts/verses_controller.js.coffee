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
      $scope.tags.push(tag)
    $scope.newTag= {} 
    #idb.add('tags', {name:$scope.tagName})
  $scope.removeTag = (tag) ->
    index = $scope.tags.indexOf(tag)
    $scope.tags.splice(index, 1)
    Category.remove {category_id: tag.id}
    #idb.delete('tags', tag.id)
  $scope.updateTag = (tag) ->
    t = Category.get {category_id: tag.id}, () ->
      t.name = tag.name
      t.$update()
    #t.$update {category_id: tag.id}

  # update tag when value change (id stay the same)
  ###
  $scope.$watch 'tags', ((newValue, oldValue) ->
    if newValue.length == oldValue.length
      oldNames = {}
      oldValue.forEach (obj) ->
        oldNames[obj.name] = obj
      newTags = newValue.filter (obj) ->
        obj.name not of oldNames
      console.log(newTags)
        #idb.put('tags', newValue, tag.id)
  ), true
  ###
