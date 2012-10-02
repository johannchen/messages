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

angular.module('messagesApp').controller 'MessageShowCtrl', ($scope, $routeParams, Message) ->
  $scope.message = Message.get {message_id: $routeParams.messageId}

angular.module('messagesApp').controller 'MessageCreateCtrl', ($scope, $location, Messages, Speakers) ->
  $scope.message = {}
  $scope.speakers = Speakers.query()
  $scope.saveMessage = ->
    m = new Messages($scope.message)
    m.$save ->
      $location.path('/')

angular.module('messagesApp').controller 'MessageEditCtrl', ($scope, $location, $routeParams, Messages, Message, Speakers) ->
  $scope.message = Message.get {message_id: $routeParams.messageId}
  $scope.speakers = Speakers.query()
  $scope.saveMessage = ->
    $scope.message.$update ->
      $location.path('/')
