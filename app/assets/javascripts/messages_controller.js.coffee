angular.module('messagesApp').controller 'MessageListCtrl', ($scope, Messages, Categories, Speakers) ->
  $scope.search = {}
  $scope.messages = Messages.query()
  $scope.categories = Categories.query()
  $scope.speakers = Speakers.query()

angular.module('messagesApp').controller 'MessageCreateCtrl', ($scope, $location, Messages, Speakers) ->
  $scope.message = {}
  $scope.speakers = Speakers.query()
  $scope.addMessage = ->
    m = new Messages($scope.message)
    m.$save ->
      $location.path('/')
