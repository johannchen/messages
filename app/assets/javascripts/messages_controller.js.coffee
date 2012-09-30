angular.module('messagesApp').controller 'MessageListCtrl', ($scope, Messages, Categories) ->
  $scope.search = {}
  $scope.messages = Messages.query()
  $scope.categories = Categories.query()

angular.module('messagesApp').controller 'MessageCreateCtrl', ($scope) ->
  $scope.search = 'Welcome'

