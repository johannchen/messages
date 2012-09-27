angular.module('versesApp').controller 'VersesCtrl', ($scope, $http, Verses, Verse, Categories, Category) ->
  $scope.newVerse = {} 
  $scope.memorized = false
  $scope.verses = Verses.query() 
  $scope.newCategory = {}
  $scope.categories = Categories.query() 
  
  $scope.getESV = ->
    esvUrl = '/verses/api/' + $scope.newVerse.ref + '.json'
    $http(
      method: 'GET'
      url: esvUrl
    ).success((data, status) ->
      $scope.newVerse.content = data
    ).error (data, status) ->
      $scope.newVerse.content = "Failed to load ESV"

  $scope.showNewVerseForm = ->
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
 
  $scope.updateVerseRef = (verse) ->
    v = Verse.get {verse_id: verse.id}, ->
      v.ref = verse.ref
      v.$update()

  $scope.updateVerseContent = (verse) ->
    v = Verse.get {verse_id: verse.id}, ->
      v.content = verse.content
      v.$update()
 
  $scope.editVerseCategories = ->
    @isEditingVerseCategories = true
  $scope.cancelEditVerseCategories = ->
    @isEditingVerseCategories = false 
  $scope.saveVerseCategories = (verse) ->
    v = Verse.get {verse_id: verse.id}, ->
      v.category_names = verse.category_names
      v.$update()
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
      v = Verse.get {verse_id: verse.id}, ->
        v.memorized = verse.memorized
        v.last_memorized_at = verse.last_memorized_at
        v.$update()
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
  $scope.removeCategory = (category) ->
    index = $scope.categories.indexOf(category)
    $scope.categories.splice(index, 1)
    Category.remove {category_id: category.id}
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
