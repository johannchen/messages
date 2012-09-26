angular.module('versesApp').controller 'VersesCtrl', ($scope, Verses, Verse, Categories, Category) ->
  $scope.newVerse = {} 
  $scope.memorized = false
  $scope.verses = Verses.query() 
  $scope.newCategory = {}
  $scope.categories = Categories.query() 
   
  $scope.newVerse = ->
    $scope.isAddingVerse = true

  $scope.cancelNewVerse = ->
    $scope.isAddingVerse = false 
    $scope.newVerse = {}

  $scope.addVerse = ->
    v = new Verses($scope.newVerse)
    v.$save (verse) ->
      $scope.verses.unshift(verse)
    $scope.newVerse = {}

  $scope.addVerseClose = ->
    $scope.addVerse()
    $scope.isAddingVerse = false 

  $scope.addVerseOpen = ->
    $scope.addVerse()
    $scope.isAddingVerse = true 

  $scope.removeVerse = (verse) ->
    index = $scope.verses.indexOf(verse)
    $scope.verses.splice(index, 1)
    Verse.remove {verse_id: verse.id}
 
  #TODO: to break down to different pieces update
  $scope.updateVerse = (verse) ->
    v = Verse.get {verse_id: verse.id}, ->
      v.ref = verse.ref
      v.content = verse.content
      v.category_names = verse.category_names if verse.category_names
      v.memorized = verse.memorized if verse.memorized
      v.last_memorized_at = verse.last_memorized_at if verse.last_memorized_at
      v.$update()
 
  $scope.editVerseCategories = ->
    @isEditingVerseCategories = true
  $scope.cancelEditVerseCategories = ->
    @isEditingVerseCategories = false 
  $scope.saveVerseCategories = (verse) ->
    $scope.updateVerse(verse)
    @isEditingVerseCategories = false 


  $scope.showMemorizeForm = ->
    @isMemorizing = true
    @doneMemorizing = false
  
  $scope.hideMemorizeForm = ->
    @isMemorizing = false
  
  $scope.memorizeVerse = ->
    @diffResult = ""
    verse = @verse
    if verse.content is @typedContent
      (if verse.memorized then ++verse.memorized else verse.memorized = 1)
      verse.last_memorized_at = new Date()
      # update verse on server
      $scope.updateVerse(verse)
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
  $scope.categorys = idb.all('categorys')
  setTimeout (->
    $rootScope.$apply()
  ), 1000
  ###
  #
  $scope.addCategory = ->
    t = new Categories($scope.newCategory)
    t.$save (category) -> 
      $scope.categories.push(category)
    $scope.newCategory= {} 
    #idb.add('categorys', {name:$scope.categoryName})
  $scope.removeCategory = (category) ->
    index = $scope.categories.indexOf(category)
    $scope.categorys.splice(index, 1)
    Category.remove {category_id: category.id}
    #idb.delete('categorys', category.id)
  $scope.updateCategory = (category) ->
    t = Category.get {category_id: category.id}, ->
      t.name = category.name
      t.$update()

  # update category when value change (id stay the same)
  ###
  $scope.$watch 'categorys', ((newValue, oldValue) ->
    if newValue.length == oldValue.length
      oldNames = {}
      oldValue.forEach (obj) ->
        oldNames[obj.name] = obj
      newCategorys = newValue.filter (obj) ->
        obj.name not of oldNames
      console.log(newCategorys)
        #idb.put('categorys', newValue, category.id)
  ), true
  ###
