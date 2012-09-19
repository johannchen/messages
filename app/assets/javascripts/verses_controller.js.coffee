angular.module('versesApp').controller 'VersesCtrl', ($scope, Verses, Verse, Categories, Category) ->
  $scope.newVerse = {} 
  $scope.verses = Verses.query() 
  $scope.addVerseClose = () ->
    v = new Verses($scope.newVerse)
    v.$save (verse) ->
      $scope.verses.push(verse)
    $scope.newVerse = {}
  $scope.removeVerse = (verse) ->
    index = $scope.verses.indexOf(verse)
    $scope.verses.splice(index, 1)
    Verse.remove {verse_id: verse.id}
    #v = Verse.get {verse_id: verse.id}, () ->
    #  v.$remove()
  $scope.updateVerse = (verse) ->
    v = Verse.get {verse_id: verse.id}, () ->
      v.ref = verse.ref
      v.content = verse.content
      v.$update()

  $scope.memorizeVerse = ->
    @diffResult = ""
    verse = @verse
    if verse.content is @typedContent
      (if verse.memorized then ++verse.memorized else verse.memorized = 1)
      verse.last_memorized_at = new Date()
      # TODO update verse on server
    else
      dmp = new diff_match_patch()
      d = dmp.diff_main(@typedContent, verse.content)
      dmp.diff_cleanupSemantic d
      @diffResult = dmp.diff_prettyHtml(d)
      @doneMemorizing = true
    @isMemorizing = false
    @typedContent = ""

 
  ### 
  # idb code
  $scope.tags = idb.all('tags')
  setTimeout (->
    $rootScope.$apply()
  ), 1000
  ###
  #
  $scope.newTag = {}
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
