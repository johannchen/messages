angular.module('messagesApp').controller 'MessageListCtrl', ($scope, Messages, Message, Categories, Speakers, Speaker) ->
  $scope.search = {}
  $scope.newSpeaker = {}
  $scope.messages = Messages.query()
  $scope.categories = Categories.query()
  $scope.speakers = Speakers.query()

  $scope.removeMessage = (message) ->
    if confirm('Are you sure to remove this message?')
      index = $scope.messages.indexOf(message)
      $scope.messages.splice(index, 1)
      Message.remove {message_id: message.id}

  $scope.filterBySpeaker = (speaker) ->
    if speaker.active 
      speaker.active = false
      $scope.search.speaker_name = ''
    else
      angular.forEach $scope.speakers, (s) ->
        s.active = false
      speaker.active = true 
      $scope.search.speaker_name = speaker.name


  $scope.addSpeaker = (speaker) ->
    s = new Speakers($scope.newSpeaker)
    s.$save (speaker) ->
      $scope.speakers.push(speaker)
    $scope.newSpeaker = {}
  
  $scope.removeSpeaker = (speaker) ->
    if confirm('Are you sure to remove this speaker?')
      index = $scope.speakers.indexOf(speaker)
      $scope.speakers.splice(index, 1)
      Speaker.remove {speaker_id: speaker.id}
  $scope.updateSpeaker = (speaker) ->
    s = Speaker.get {speaker_id: speaker.id}, ->
      s.name = speaker.name
      s.$update()

  $scope.editMessageCategories = ->
    @isEditingMessageCategories = true
  $scope.cancelEditMessageCategories = ->
    @isEditingMessageCategories = false 
  $scope.saveMessageCategories = (message) ->
    m = Message.get {message_id: message.id}, ->
      m.category_names = message.category_names
      m.$update()
    @isEditingMessageCategories = false 

  # TODO: DRY
  $scope.filterByCategory = (category) ->
    if category.active 
      category.active = false
      $scope.search.category_names = ''
    else
      angular.forEach $scope.categories, (cat) ->
        cat.active = false
      category.active = true 
      $scope.search.category_names = category.name

  $scope.addCategory = ->
    t = new Categories($scope.newCategory)
    t.$save (category) -> 
      $scope.categories.push(category)
    $scope.newCategory= {} 
  $scope.removeCategory = (category) ->
    if confirm('Are you sure to remove this category?')
      index = $scope.categories.indexOf(category)
      $scope.categories.splice(index, 1)
      Category.remove {category_id: category.id}
  $scope.updateCategory = (category) ->
    t = Category.get {category_id: category.id}, ->
      t.name = category.name
      t.$update()

angular.module('messagesApp').controller 'MessageShowCtrl', ($scope, $route, $routeParams, Message, Verse, ESV) ->
  $scope.versesChanged = false 
  $scope.message = Message.get {message_id: $routeParams.messageId}
  $scope.addVerse = ->
    $scope.message.verses.push(ESV.get {ref: $scope.newVerse})
    $scope.message.verse_refs.push($scope.newVerse)
    $scope.newVerse = ''
    $scope.versesChanged = true
  $scope.removeVerse = (verse) ->
    index = $scope.message.verses.indexOf(verse)
    $scope.message.verses.splice(index, 1)
    refIndex = $scope.message.verse_refs.indexOf(verse.ref)
    $scope.message.verse_refs.splice(refIndex, 1)
    $scope.versesChanged = true
  $scope.favorVerse = (verse) ->
    @verse.favorite = true
    v = Verse.get {verse_id: verse.id}, ->
      v.favorite = true
      v.$update()

  $scope.saveVerses = ->
    $scope.message.$update()
    $scope.versesChanged = false 
  $scope.cancel = ->
    $route.reload()

angular.module('messagesApp').controller 'MessageCreateCtrl', ($scope, $location, Messages, Speakers) ->
  $scope.message = {}
  $scope.speakers = Speakers.query()
  $scope.saveMessage = ->
    m = new Messages($scope.message)
    m.$save ->
      $location.path('/')

angular.module('messagesApp').controller 'MessageEditCtrl', ($scope, $location, $routeParams, Message, Speakers) ->
  Message.get {message_id: $routeParams.messageId}, (m) ->
    $scope.message = m
  $scope.speakers = Speakers.query()
  $scope.saveMessage = ->
    $scope.message.$update ->
      $location.path('/')
